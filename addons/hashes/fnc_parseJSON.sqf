#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_parseJSON

Description:
    Deserializes a JSON string.

Parameters:
    _json       - String containing valid JSON. <STRING>
    _objectType - Selects the type used for deserializing objects (optional) <BOOLEAN or NUMBER>
                  0, false: CBA namespace (default)
                  1, true:  CBA hash
                  2:        Native hash map

Returns:
    _object     - The deserialized JSON object.
                  <LOCATION, ARRAY, STRING, NUMBER, BOOL, HASHMAP, NIL>

Examples:
    (begin example)
        private _json = "{ ""enabled"": true }";
        private _settings = [_json] call CBA_fnc_parseJSON;
        private _enabled = _settings getVariable "enabled";

        loadFile "data\config.json" call CBA_fnc_parseJSON
        [preprocessFile "data\config.json", true] call CBA_fnc_parseJSON
    (end)

Author:
    initramfs
---------------------------------------------------------------------------- */
SCRIPT(parseJSON);
params [["_json", "", [""]], ["_objectType", 0]];

// Enable unicode processing
forceUnicode 0;

/**
 * Helper function returning the code used for object creation based on the "_objectType" parameter.
 */
private _createObject = {
    switch (_objectType) do {
        case false;
        case 0: {
            [] call CBA_fnc_createNamespace
        };

        case true;
        case 1: {
            [] call CBA_fnc_hashCreate
        };

        case 2: {
            createHashMap
        };
    };
};

/**
 * Helper function to set a key-value pair within an object based on the "_objectType" parameter.
 */
private _objectSet = {
    params ["_obj", "_key", "_val"];

    switch (_objectType) do {
        case false;
        case 0: {
            _obj setVariable [_key, _val];
        };

        case true;
        case 1: {
            [_obj, _key, _val] call CBA_fnc_hashSet;
        };

        case 2: {
            _obj set [_key, _val];
        };
    };
};

/**
 * Tokenizes the input JSON string into an array of tuples of the format: (token, [row, column]).
 *
 * @param _jsonStr The JSON string to tokenize.
 * @return An array of token tuples.
 */
private _tokenize = {
    params [["_jsonStr", objNull, [""]]];

    if !(_jsonStr isEqualType "") exitWith {
        objNull
    };

    private _tokens = [];

    private _symbolsArr = "{}[]:," splitString "";
    private _numberArr = "-0123456789" splitString "";
    private _whitespaceChars = toString [0x9, 0xA, 0xD, 0x20];

    private _constRegex = "true|false|null/o";
    private _numberRegex = "(-?(?:(?:[1-9]\d*)|\d)(?:\.\d+)?(?:[eE][+-]?\d+)?).*/o";
    private _hexStrRegex = "[\da-f]{4}/io";

    private _strEscapeMap = createHashMapFromArray [
        ["""", """"],
        ["\", "\"],
        ["/", "/"],
        ["b", toString [8]],
        ["f", toString [12]],
        ["n", toString [10]],
        ["r", toString [13]],
        ["t", toString [9]]
    ];
    private _strHexMap = createHashMapFromArray [
        ["0", 0x0], ["1", 0x1], ["2", 0x2], ["3", 0x3], ["4", 0x4], ["5", 0x5], ["6", 0x6], ["7", 0x7],
        ["8", 0x8], ["9", 0x9], ["a", 0xa], ["b", 0xb], ["c", 0xc], ["d", 0xd], ["e", 0xe], ["f", 0xf]
    ];

    // Convert input string into code points
    private _codePoints = _jsonStr splitString "";

    private _rowIndex = 0;
    private _columnIndex = 0;

    while {count _codePoints > 0} do {
        // Match against constants
        private _rmatch = flatten (((_codePoints select [0, 5]) joinString "") regexFind [_constRegex]);
        if (count _rmatch > 0) then {
            // Ensure match starts at beginning
            if (_rmatch # 1 == 0) then {
                switch (_rmatch # 0) do {
                    case "true": {
                        _tokens pushBack [true, [_rowIndex, _columnIndex]];
                        _columnIndex = _columnIndex + 4;
                        _codePoints deleteRange [0, 4];
                        continue;
                    };

                    case "false": {
                        _tokens pushBack [false, [_rowIndex, _columnIndex]];
                        _columnIndex = _columnIndex + 5;
                        _codePoints deleteRange [0, 5];
                        continue;
                    };

                    case "null": {
                        _tokens pushBack [objNull, [_rowIndex, _columnIndex]];
                        _columnIndex = _columnIndex + 4;
                        _codePoints deleteRange [0, 4];
                        continue;
                    }
                };
            };
        };

        // Get first code point for matching
        private _cp = _codePoints # 0;

        // Match against whitespace
        if (_cp in _whitespaceChars) then {
            // Omit whitespace from tokenized output
            _codePoints deleteAt 0;
            _columnIndex = _columnIndex + 1;

            // Increment row index on LF (0xA)
            if ((toArray _cp) # 0 == 0xA) then {
                _rowIndex = _rowIndex + 1;
                _columnIndex = 0;
            };

            continue;
        };

        // Match against literal symbols
        if (_cp in _symbolsArr) then {
            _tokens pushBack [_codePoints deleteAt 0, [_rowIndex, _columnIndex]];
            _columnIndex = _columnIndex + 1;
            continue;
        };

        // Match against number
        if (_cp in _numberArr) then {
            // Attempt to create longest token that satisfies the "number" symbol
            private _numberSym = _cp;
            private _numberExtent = 1;

            while {true} do {
                // We jump forward 3 code points at a time to ensure the number under construction always makes progress
                private _ncps = (_codePoints select [_numberExtent, 3]) joinString "";

                if (count _ncps == 0) then {
                    // At the end of input with nothing left to process
                    break;
                };

                private _rmatch = ((_numberSym + _ncps) regexFind [_numberRegex, 0]);
                if (count _rmatch == 0) then {
                    throw format ["invalid number token at %1:%2", _rowIndex + 1, _columnIndex + 1];
                };

                _rmatch = _rmatch # 0 # 1;
                if (_rmatch # 1 != 0) then {
                    // Regex match must be at the beginning to denote a valid number
                    throw format ["invalid number token at %1:%2", _rowIndex + 1, _columnIndex + 1];
                };

                private _nextNumberSym = _rmatch # 0;
                private _newCodePointCount = count _nextNumberSym - _numberExtent;

                if (_newCodePointCount == 0) then {
                    // We're at the end of our number since we haven't made any forward progress
                    break;
                };

                _numberSym = _nextNumberSym;
                _numberExtent = _numberExtent + _newCodePointCount;
            };

            // Reject case where the match is a single minus sign
            if (_numberSym == "-") then {
                throw format ["invalid number token at %1:%2", _rowIndex + 1, _columnIndex + 1];
            };

            _tokens pushBack [parseNumber _numberSym, [_rowIndex, _columnIndex]];
            _columnIndex = _columnIndex + _numberExtent;
            _codePoints deleteRange [0, _numberExtent];
            continue;
        };

        // Match against string
        if (_cp == """") then {
            private _strSym = "$";
            private _strExtent = 1;

            private _currentlyEscaping = false;

            while {true} do {
                private _ncp = _codePoints # _strExtent;

                if (isNil "_ncp") then {
                    // End of input reached before string terminated
                    throw format ["unterminated string token at %1:%2", _rowIndex + 1, _columnIndex + 1];
                };

                _strExtent = _strExtent + 1;

                if (_currentlyEscaping) then {
                    if (!(_ncp in _strEscapeMap) && _ncp != "u") then {
                        throw format ["invalid string escape char '%1' at %2:%3", _ncp, _rowIndex + 1, _columnIndex + _strExtent];
                    };

                    if (_ncp in _strEscapeMap) then {
                        _strSym = _strSym + (_strEscapeMap get _ncp);
                    } else {
                        private _hexStr = _codePoints select [_strExtent, 4];
                        _strExtent = _strExtent + 4;

                        if !((_hexStr joinString "") regexMatch _hexStrRegex) then {
                            // Invalid hex string
                            throw format ["invalid hex string '%1' at %2:%3", _hexStr, _rowIndex + 1, _columnIndex + 1];
                        };

                        private _cp = 0;
                        {
                            private _digit = _strHexMap get (toLower _x);
                            _cp = _cp + (16 ^ (count _hexStr - _forEachIndex - 1)) * _digit;
                        } forEach _hexStr;

                        _strSym = _strSym + (toString [_cp]);
                    };

                    _currentlyEscaping = false;
                    continue;
                };

                if (_ncp == """") then {
                    break;
                };

                if (_ncp == "\") then {
                    _currentlyEscaping = true;
                    continue;
                };

                private _ncpValue = (toArray _ncp) # 0;
                if (_ncpValue < 0x20 || _ncpValue > 0x10FFFF) then {
                    throw format ["invalid string code point at %1:%2", _rowIndex + 1, _columnIndex + _strExtent];
                };

                _strSym = _strSym + _ncp;
            };

            _tokens pushBack [_strSym, [_rowIndex, _columnIndex]];
            _columnIndex = _columnIndex + _strExtent;
            _codePoints deleteRange [0, _strExtent];
            continue;
        };

        throw format ["unexpected token at %1:%2", _rowIndex + 1, _columnIndex + 1];
    };

    // Return parsed tokens
    _tokens
};

/**
 * Shifter function as part of the shift-reduce parser to shift the next token onto the token stack.
 *
 * @param _parseStack The current parsing stack as an array.
 * @param _tokens Array of remaining tokens to shift.
 * @return true if a token could be shifted onto the stack, false if no tokens are left.
 */
private _shift = {
    params [["_parseStack", [], [[]]], ["_tokens", [], [[]]]];

    if (count _tokens > 0) then {
        // Append token reduction state on to end of each token
        _parseStack pushBack ((_tokens deleteAt 0) + [false]);
        true
    } else {
        false
    };
};

/**
 * Reducer function as part of the shift-reduce parser to reduce at most 1 element form the current parsing stack.
 *
 * This reducer stores additional state information for faster lookup through the parsing stack. Subsequent calls to
 * reduce must pass the same reducer state object into the reducer.
 *
 * @param _parseStack The current parsing stack as an array.
 * @param _reducerState Additional state information stored by the reducer, must be a hash map.
 */
private _reduce = {
    params [["_parseStack", [], [[]]], ["_reducerState", createHashMap, [createHashMap]]];

    if (count _parseStack == 0) exitWith {
        false
    };

    // Initialize reducer state if not already initialized
    if !("STACK_{" in _reducerState) then {
        _reducerState set ["STACK_{", []];
    };
    if !("STACK_[" in _reducerState) then {
        _reducerState set ["STACK_[", []];
    };

    private _objOpenStack = (_reducerState get "STACK_{");
    private _arrOpenStack = (_reducerState get "STACK_[");

    private _topToken = _parseStack select -1;

    // Handle terminal symbols
    switch (true) do {
        case (_topToken # 0 isEqualType 0): {
            _topToken set [2, true];
        };

        case (_topToken # 0 isEqualType true): {
            _topToken set [2, true];
        };

        case (_topToken # 0 isEqualTo objNull): {
            _topToken set [2, true];
        };

        case ((_topToken # 0 select [0, 1]) == "$"): {
            _topToken set [0, (_topToken # 0) select [1]];
            _topToken set [2, true];
        };
    };

    // Exit if we've successfully reduced the token
    if (_topToken # 2) exitWith {};

    switch (_topToken # 0) do {
        case "{": {
            _objOpenStack pushBack (count _parseStack - 1);
        };

        case "[": {
            _arrOpenStack pushBack (count _parseStack - 1);
        };

        case "}": {
            if (count _objOpenStack == 0) then {
                throw format (["invalid '}' token at %1:%2"] + ((_topToken # 1) apply { _x + 1 }));
            };

            private _objStart = _objOpenStack deleteAt (count _objOpenStack - 1);
            private _objLen = count _parseStack - _objStart;

            private _obj = [] call _createObject;
            private _objEmpty = true;

            // Object creation state machine (0 => key, 1 => colon, 2 => value, 3 => comma)
            private _nextTokenType = 0;
            private _currentKey = "";

            {
                switch (_nextTokenType) do {
                    case 0: {
                        if !(_x # 2) then {
                            throw format (["invalid '%1' token at %2:%3", _x # 0] + ((_x # 1) apply { _x + 1 }));
                        };

                        if !(_x # 0 isEqualType "") then {
                            throw format (["invalid key token at %1:%2"] + ((_x # 1) apply { _x + 1 }));
                        };

                        _currentKey = _x # 0;
                    };

                    case 1: {
                        if (_x # 2 || _x # 0 != ":") then {
                            throw format (["missing colon token at %1:%2"] + ((_x # 1) apply { _x + 1 }));
                        };
                    };

                    case 2: {
                        if !(_x # 2) then {
                            throw format (["invalid '%1' token at %2:%3", _x # 0] + ((_x # 1) apply { _x + 1 }));
                        };

                        [_obj, _currentKey, _x # 0] call _objectSet;
                        _objEmpty = false;
                    };

                    case 3: {
                        if (_x # 2 || _x # 0 != ",") then {
                            throw format (["missing comma token at %1:%2"] + ((_x # 1) apply { _x + 1 }));
                        };
                    };
                };

                _nextTokenType = (_nextTokenType + 1) % 4;
            } forEach (_parseStack select [_objStart + 1, _objLen - 2]);

            // Validate object definition state machine is in correct final state
            if (_objEmpty) then {
                if (_nextTokenType != 0) then {
                    throw format (["incomplete object definition at %1:%2"] + ((_topToken # 1) apply { _x + 1 }));
                };
            } else {
                if (_nextTokenType == 0) then {
                    private _commaToken = _parseStack select -2;
                    throw format (["extraneous comma at %1:%2"] + ((_commaToken # 1) apply { _x + 1 }));
                };

                if (_nextTokenType != 3) then {
                    throw format (["incomplete object definition at %1:%2"] + ((_topToken # 1) apply { _x + 1 }));
                }
            };

            private _objToken = _parseStack # _objStart;
            _objToken set [0, _obj];
            _objToken set [2, true];

            _parseStack deleteRange [_objStart + 1, _objLen - 1];
        };

        case "]": {
            if (count _arrOpenStack == 0) then {
                throw format (["invalid ']' token at %1:%2"] + ((_topToken # 1) apply { _x + 1 }));
            };

            private _arrStart = _arrOpenStack deleteAt (count _arrOpenStack - 1);
            private _arrLen = count _parseStack - _arrStart;

            private _arr = [];
            private _nextTokenItem = true;

            {
                if (_nextTokenItem) then {
                    if !(_x # 2) then {
                        throw format (["invalid '%1' token at %2:%3", _x # 0] + ((_x # 1) apply { _x + 1 }));
                    };

                    _arr pushBack (_x # 0);
                    _nextTokenItem = false;
                } else {
                    if (_x # 2 || _x # 0 != ",") then {
                        throw format (["missing comma at %1:%2"] + ((_x # 1) apply { _x + 1 }));
                    };

                    _nextTokenItem = true;
                };
            } forEach (_parseStack select [_arrStart + 1, _arrLen - 2]);

            if (_nextTokenItem && count _arr > 0) then {
                private _commaToken = _parseStack select -2;
                throw format (["extraneous comma at %1:%2"] + ((_commaToken # 1) apply { _x + 1 }));
            };

            private _arrToken = _parseStack # _arrStart;
            _arrToken set [0, _arr];
            _arrToken set [2, true];

            _parseStack deleteRange [_arrStart + 1, _arrLen - 1];
        };
    };
};

/**
 * Primary parsing function that combines the tokenization and shift-reduce stages together to parse the JSON string.
 *
 * @param _jsonStr The JSON string to parse.
 * @return The parsed JSON object.
 */
private _parse = {
    params [["_jsonStr", objNull, [""]]];

    if !(_jsonStr isEqualType "") exitWith {
        objNull
    };

    private _tokens = [_jsonStr] call _tokenize;

    if (count _tokens == 0) then {
        throw "empty JSON document";
    };

    private _parseStack = [];
    private _reducerState = createHashMap;

    while {true} do {
        if !([_parseStack, _tokens] call _shift) then {
            break;
        };

        [_parseStack, _reducerState] call _reduce;
    };

    if (count _parseStack > 1) then {
        private _extraneousToken = _parseStack # 1;
        throw format (["extraneous '%1' token at %2:%3", _extraneousToken # 0] + ((_extraneousToken # 1) apply { _x + 1 }));
    };

    // Extract and return parsed object
    _parseStack # 0 # 0
};

private _jsonValue = [_json] call _parse;

// Reset unicode processing
forceUnicode -1;

_jsonValue
