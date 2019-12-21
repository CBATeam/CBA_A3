#define DEBUG_MODE_FULL
#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_parseJSON

Description:
    Converts a JSON formatted string into a CBA Hash array.

Parameters:
    _file - The JSON string. <STRING>

Returns:
    Hash data structure taken from the file, or nil if file had syntax errors.

Examples:
(begin example)
    _hash = _file call CBA_fnc_parseJSON;
(end)

Author:
    Tupolov, commy2
---------------------------------------------------------------------------- */
#define JSON_MODE_VALUE 0
#define JSON_MODE_KEY 1

#define JSON_TYPE_ARRAY 2
#define JSON_TYPE_STRING 3
#define JSON_TYPE_OBJECT 4

// JSON specific tokens
#define JSON_OBJECT_START 123
#define JSON_OBJECT_FINISH 125
#define JSON_ARRAY_START 91
#define JSON_ARRAY_FINISH 93

// JSON terminators - colon for end of key, comma for end of value.
#define ASCII_COLON 58
#define ASCII_COMMA 44
// ----------------------------------------------------------------------------

private _fnc_parse = {
    // Accepts array of characters as ASCII codes.
    // Returns Hash | Array values and pos.
    scopeName "main";
    private _return = [];
    #define RETURN (_return breakOut "main")
    #define LOOP for "_" from 0 to 1 step 0 do

    params ["_charArray", "_pos", "_mode", "_type"];
    TRACE_1("Parse",toString _charArray);

    private _key = "";
    private _value = nil;

    if (isNil {_charArray select _pos}) exitWith {
        ERROR_2("charArray too small. pos = %1, charArray = %2",_pos,_charArray);
        false
    };

    private ["_tempHash", "_tempArray"];
    TRACE_2("Starting at",_pos,_charArray select _pos);
    switch (_type) do {
        case JSON_TYPE_OBJECT: {
            _tempHash = [] call CBA_fnc_hashCreate;
            TRACE_1("Creating hash",_tempHash);
        };

        case JSON_TYPE_ARRAY: {
            _tempArray = [];
        };
    };

    LOOP {
        private _continue = true;

        switch (_mode) do {
        case JSON_MODE_KEY: {
            private _tempKey = [];

            while {_continue} do {
                private _char = _charArray select _pos;

                if (isNil "_char") exitWith {
                    ERROR_2("Parsing JSON. charArray = %1 and pos = %2",_charArray,_pos);
                    _continue = false;
                    RETURN;
                };

                if (_char == ASCII_COLON) then {
                    // End of key.
                    TRACE_1("Setting Key",toString _tempKey);
                    _key = toString _tempKey call CBA_fnc_trim;

                    // Remove quotes.
                    if (_key select [0,1] == """" && _key select [count _key - 1] == """") then {
                        _key = _key select [1, count _key - 2];
                    };

                    _mode = JSON_MODE_VALUE;
                    _continue = false;
                } else {
                    _tempKey pushBack _char;
                };

                _pos = _pos + 1;
            };
        };

        case JSON_MODE_VALUE: {
            private _tempValue = [];

            while {_continue} do {
                private _char = _charArray select _pos;

                if (isNil "_char") exitWith {
                    ERROR_2("Parsing JSON. charArray = %1 and pos = %2",_charArray,_pos);
                    _continue = false;
                    RETURN;
                };

                switch (_char) do {
                case JSON_OBJECT_START: {
                    _pos = _pos + 1;
                    TRACE_1("Starting hash",_pos);

                    private _temp = [_charArray, _pos, JSON_MODE_KEY, JSON_TYPE_OBJECT] call _fnc_parse;
                    _value = _temp select 0;
                    _pos = _temp select 1;
                    TRACE_1("Got hash",_value);

                    _mode = JSON_MODE_VALUE;
                    _continue = false;
                };

                case JSON_OBJECT_FINISH: {
                    [_tempHash, _key, _value] call CBA_fnc_hashSet;
                    TRACE_1("Finishing hash",_tempHash);

                    _return = [_tempHash, _pos];
                    _continue = false;
                    RETURN;
                };

                case JSON_ARRAY_START: {
                    _pos = _pos + 1;
                    TRACE_1("Starting array",_pos);

                    private _temp = [_charArray, _pos, JSON_MODE_VALUE, JSON_TYPE_ARRAY] call _fnc_parse;
                    _value = _temp select 0;
                    _pos = _temp select 1;

                    _mode = JSON_MODE_VALUE;
                    _continue = false;
                };

                case JSON_ARRAY_FINISH: {
                    if (isNil "_value") then {
                        _tempArray = [];
                    } else {
                        _tempArray pushBack _value;
                    };
                    TRACE_1("Finishing array",_tempArray);

                    _return = [_tempArray, _pos];
                    _continue = false;
                    RETURN;
                };

                case ASCII_COMMA: {
                    // Means end of value.
                    switch (_type) do {
                        case JSON_TYPE_OBJECT: {
                            TRACE_2("Setting hash",_key,_value);
                            [_tempHash, _key, _value] call CBA_fnc_hashSet;

                            _mode = JSON_MODE_KEY;
                            _continue = false;
                        };

                        case JSON_TYPE_ARRAY: {
                            TRACE_2("Setting array",_tempArray,_value);
                            _tempArray pushBack _value;
                            _tempValue = [];
                        };
                    };
                };

                default {
                    _tempValue pushBack _char;
                    _value = toString _tempValue call CBA_fnc_trim;

                    // Remove quotes.
                    if (_value select [0,1] == """" && _value select [count _value - 1] == """") then {
                        _value = _value select [1, count _value - 2];
                    };
                    //parseSimpleArray format ["[%1]", _thing] select 0

                    if (_value == "any") then {
                        _value = "nil";
                    };
                };
                };

                _pos = _pos + 1;
            };
        };
        };
    };
};

// MAIN
params [["_file", "", [""]]];
_file = loadFile _file;

if (toUpper _file in ["", " ", "ERROR", "UNAUTHORISED!"]) exitWith {"ERROR"};

// Create an array of characters from the JSON string.
private _charArray = toArray _file;

// Set position to start with (skip " character) and start parsing.
private _pos = 1;
[_charArray, _pos, JSON_MODE_KEY, JSON_TYPE_OBJECT] call _fnc_parse select 0 // return
