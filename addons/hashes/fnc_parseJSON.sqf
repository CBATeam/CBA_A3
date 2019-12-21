#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_parseJSON

Description:
    Converts a JSON formatted string into a CBA Hash array.

Parameters:
    _file - The JSON string <STRING>.

Returns:
    Hash data structure taken from the file, or nil if file had syntax errors.

Examples:
(begin example)
    _hash = [_input] call CBA_fnc_parseJSON;
(end)

Author:
    Tupolov, commy2
---------------------------------------------------------------------------- */
#define JSON_MODE_VALUE 0
#define JSON_MODE_KEY 1

#define JSON_TYPE_ARRAY 2
#define JSON_TYPE_STRING 3
#define JSON_TYPE_OBJECT 4

// JSON Specific tokens
#define JSON_OBJECT_START 123
#define JSON_OBJECT_FINISH 125
#define JSON_ARRAY_START 91
#define JSON_ARRAY_FINISH 93

// JSON terminators - colon for end of key, comma for end of value
#define ASCII_COLON 58
#define ASCII_COMMA 44
#define ASCII_QUOTES 34
/* ------------------------------------------------------------------------- */

private ["_string","_charArray","_mode","_type","_result","_pos","_retval"];

private _fnc_parse = {
    // Accepts array of characters as ASCII codes
    // Returns Hash | Array values and pos
    private ["_charArray","_pos","_mode","_return","_type","_key","_done","_result","_tmpArr","_value","_tmpHash","_tmpStr","_origType"];

    // TRACE_1("Parse", toString (_this select 0));

    _charArray = _this select 0;
    _pos = _this select 1;
    _mode = _this select 2;
    _type = _this select 3;
    _origType = _type;
    _key = "";
    _return = false;

    _check = _charArray select _pos;
    if (isNil "_check") exitWith {
        diag_log format["Error charArray too small: %1, %2", _pos, _charArray];
        _return;
    };

        TRACE_2("Starting at", _pos, _charArray select _pos);
    switch (_type) do {
        case JSON_TYPE_OBJECT: {
            _tmpHash = [] call CBA_fnc_hashCreate;
            // TRACE_1("Creating hash", _tmpHash);
        };
        case JSON_TYPE_ARRAY: {
            _tmpArr = [];
        };
        case default {
            _tmpStr = "";
        };
    };

        while {!_return} do {
        _done = false;
        switch (_mode) do {
            case JSON_MODE_KEY:
            {
                private ["_tmpKey"];
                _tmpKey = [];
                while {!_done} do {
                    private ["_char"];
                    _char = 0;
                    _char = _charArray select _pos;
                    if (isNil "_char") exitWith {diag_log format["PARSE JSON: ERROR charArray = %1 and pos = %2",_charArray, _pos];_done = true; _return = true;};
                    if (_char == ASCII_COLON) then {
                        // End of Key
                        //TRACE_1("Setting Key", toString _tmpKey);
                        _key = toString _tmpKey;
                        _mode = JSON_MODE_VALUE;
                        _done = true;
                    } else {
                        if (_char != ASCII_QUOTES) then {
                            _tmpKey pushback _char;
                        };
                    };
                    _pos = _pos + 1;
                };
            };
            case JSON_MODE_VALUE:
            {
                private ["_tmpVal"];
                _tmpVal = [];
                while {!_done} do {
                    private ["_char"];
                    _char = _charArray select _pos;
                    if (isNil "_char") exitWith {diag_log format["PARSE JSON: ERROR charArray = %1 and pos = %2",_charArray, _pos];_done = true; _return = true;};
                    switch (_char) do {
                        case JSON_OBJECT_START:{
                            private "_retval";
                            _mode = JSON_MODE_KEY;
                            _type = JSON_TYPE_OBJECT;
                            _pos = _pos + 1;
                            // TRACE_1("Starting hash", _pos);
                            _retval = [_charArray, _pos,_mode, _type] call _fnc_parse;
                            _value = _retval select 0;
                             TRACE_1("Got hash", _value);
                            _pos = _retval select 1;
                            _mode = JSON_MODE_VALUE;
                            _type = _origType;
                            _done = true;
                        };
                        case JSON_OBJECT_FINISH:{
                            [_tmpHash, _key, _value] call CBA_fnc_hashSet;
                            // TRACE_1("Finishing hash", _tmpHash);
                            _result = [_tmpHash, _pos];
                            _done = true;
                            _return = true;
                        };
                        case JSON_ARRAY_START:{
                            private "_retval";
                            _mode = JSON_MODE_VALUE;
                            _type = JSON_TYPE_ARRAY;
                            _pos = _pos + 1;
                             TRACE_1("Starting array", _pos);
                            _retval = [_charArray, _pos,_mode, _type] call _fnc_parse;
                            _value = _retval select 0;
                            _pos = _retval select 1;
                            _type = _origType;
                            _done = true;
                        };
                        case JSON_ARRAY_FINISH:{
                            if (isNil "_value") then {
                                _tmpArr = [];
                            } else {
                                _tmpArr pushback _value;
                            };
                             TRACE_1("Finishing array", _tmpArr);
                            _result = [_tmpArr,_pos];
                            _done = true;
                            _return = true;
                        };
                        case ASCII_COMMA:{
                            // means end of value
                            if (isNil "_value") then {
                                _value = "";
                            };
                            switch (_type) do {
                                case JSON_TYPE_OBJECT: {
                                    TRACE_2("setting hash", _key, _value);
                                    [_tmpHash, _key, _value] call CBA_fnc_hashSet;
                                    _mode = JSON_MODE_KEY;
                                    _done = true;
                                    _value = "";
                                };
                                case JSON_TYPE_ARRAY: {
                                     TRACE_2("setting array", _tmpArr, _value);
                                    _tmpArr pushback _value;
                                    _tmpVal = [];
                                    _value = "";
                                };
                                case default {
                                    TRACE_2("setting value", _key, _value);
                                    _value = toString _tmpVal;
                                    _mode = JSON_MODE_KEY;
                                    _done = true;
                                };
                            };
                        };
                        case default {
                            // must be a String Value
                            if (_char != ASCII_QUOTES) then {
                                _tmpVal pushback _char;
                                _value = toString _tmpVal;
                                if (_value == "any") then {_value = "nil";};
                            };

                        };
                    };

                    _pos = _pos + 1;

                };
            };
        };
    };

    _result
};

// MAIN

_string = loadFile (_this select 0);

//diag_log _string;

if (_string == "" || _string == " " || _string == "ERROR" || _string == "UNAUTHORISED!") exitWith {_result = "ERROR"; _result};

// Create an array of characters from the JSON string
_charArray = toArray _string;

// Set position to start with (skip " character)
_pos = 1;

_mode = JSON_MODE_KEY;
_type = JSON_TYPE_OBJECT;

// Start parsing
_retval = [_charArray, _pos,_mode, _type] call _fnc_parse;

_result = _retval select 0;

_result
