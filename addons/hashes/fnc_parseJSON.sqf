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
    _object     - The deserialized JSON object or nil if JSON is invalid.
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
    BaerMitUmlaut
---------------------------------------------------------------------------- */
SCRIPT(parseJSON);
params ["_json", ["_objectType", 0]];

// Wrappers for creating "objects" and setting values on them
private ["_objectSet", "_createObject"];

switch (_objectType) do {
    case false;
    case 0: {
        _createObject = CBA_fnc_createNamespace;
        _objectSet = {
            params ["_obj", "_key", "_val"];
            _obj setVariable [_key, _val];
        };
    };

    case true;
    case 1: {
        _createObject = CBA_fnc_hashCreate;
        _objectSet = CBA_fnc_hashSet;
    };

    case 2: {
        _createObject = { createHashMap };
        _objectSet = {
            params ["_obj", "_key", "_val"];
            _obj set [_key, _val];
        };
    };
};

// Handles escaped characters, except for unicode escapes (\uXXXX)
private _unescape = {
    params ["_char"];

    switch (_char) do {
        case """": { """" };
        case "\": { "\" };
        case "/": { "/" };
        case "b": { toString [8] };
        case "f": { toString [12] };
        case "n": { endl };
        case "r": { toString [13] };
        case "t": { toString [9] };
        default { "" };
    };
};

// Splits the input string into tokens
// Tokens can be numbers, strings, null, true, false and symbols
// Strings are prefixed with $ to distinguish them from symbols
private _tokenize = {
    params ["_input"];

    // Split string into chars, works with unicode unlike splitString
    _input = toArray _input apply {toString [_x]};

    private _tokens  = [];
    private _numeric = "+-.0123456789eE" splitString "";
    private _symbols = "{}[]:," splitString "";
    private _consts  = "tfn" splitString "";

    while {count _input > 0} do {
        private _c = _input deleteAt 0;

        switch (true) do {
            // Symbols ({}[]:,) are passed directly into the tokens
            case (_c in _symbols): {
                _tokens pushBack _c;
            };

            // Number parsing
            // This can fail with some invalid JSON numbers, like e10
            // Those would require some additional logic or regex
            // Valid numbers are all parsed correctly though
            case (_c in _numeric): {
                private _numStr = _c;
                while { _c = _input deleteAt 0; !isNil "_c" && {_c in _numeric} } do {
                    _numStr = _numStr + _c;
                };
                _tokens pushBack parseNumber _numStr;

                if (!isNil "_c") then {
                    _input = [_c] + _input;
                };
            };

            // true, false and null
            // Only check first char and assume JSON is valid
            case (_c in _consts): {
                switch (_c) do {
                    case "t": {
                        _input deleteRange [0, 3];
                        _tokens pushBack true;
                    };
                    case "f": {
                        _input deleteRange [0, 4];
                        _tokens pushBack false;
                    };
                    case "n": {
                        _input deleteRange [0, 3];
                        _tokens pushBack objNull;
                    };
                };
            };

            // String parsing
            case (_c == """"): {
                private _str = "$";

                while {true} do {
                    _c = _input deleteAt 0;

                    if (_c == """") exitWith {};

                    if (_c == "\") then {
                        _str = _str + ((_input deleteAt 0) call _unescape);
                    } else {
                        _str = _str + _c;
                    };
                };

                _tokens pushBack _str;
            };
        };
    };

    _tokens
};

// Appends the next token to the parsing stack
// Returns true unless no more tokens left
private _shift = {
    params ["_parseStack", "_tokens"];

    if (count _tokens > 0) then {
        _parseStack pushBack (_tokens deleteAt 0);
        true
    } else {
        false
    };
};

// Tries to reduce the current parsing stack (collect arrays or objects)
// Returns true if parsing stack could be reduced
private _reduce = {
    params ["_parseStack", "_tokens"];

    // Nothing to reduce
    if (count _parseStack == 0) exitWith { false };

    // Check top of stack
    switch (_parseStack#(count _parseStack - 1)) do {

        // Reached end of array, time to collect elements
        case "]": {
            private _array = [];

            // Empty arrays need special handling
            if (_parseStack#(count _parseStack - 2) isNotEqualTo "[") then {
                // Get next token, if [ beginning is reached, otherwise assume
                // valid JSON and that the token is a comma
                while {_parseStack deleteAt (count _parseStack - 1) != "["} do {
                    private _element = _parseStack deleteAt (count _parseStack - 1);

                    // Remove $ prefix from string
                    if (_element isEqualType "") then {
                        _element = _element select [1];
                    };

                    _array pushBack _element;
                };

                reverse _array;
            } else {
                _parseStack resize (count _parseStack - 2);
            };

            _parseStack pushBack _array;
            true
        };

        // Reached end of array, time to collect elements
        // Works very similar to arrays
        case "}": {
            private _object = [] call _createObject;

            // Empty objects need special handling
            if (_parseStack#(count _parseStack - 2) isNotEqualTo "{") then {
                // Get next token, if { beginning is reached, otherwise assume
                // valid JSON and that token is comma
                while {_parseStack deleteAt (count _parseStack - 1) != "{"} do {
                    private _value = _parseStack deleteAt (count _parseStack - 1);
                    private _colon = _parseStack deleteAt (count _parseStack - 1);
                    private _name  = _parseStack deleteAt (count _parseStack - 1);

                    // Remove $ prefix from strings
                    if (_value isEqualType "") then {
                        _value = _value select [1];
                    };
                    _name = _name select [1];

                    [_object, _name, _value] call _objectSet;
                };
            } else {
                _parseStack resize (count _parseStack - 2);
            };

            _parseStack pushBack _object;
            true
        };

        default {
            false
        };
    };
};

// Simple shift-reduce parser
private _parse = {
    params ["_tokens"];
    private _parseStack = [];
    private _params = [_parseStack, _tokens];

    while { _params call _reduce || {_params call _shift} } do {};

    if (count _parseStack != 1) then {
        nil
    } else {
        private _object = _parseStack#0;

        // If JSON is just a string, remove $ prefix from it
        if (_object isEqualType "") then {
            _object = _object select [1];
        };

        _object
    };
};

[_json call _tokenize] call _parse
