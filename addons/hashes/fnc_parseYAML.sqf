#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_parseYAML

Description:
    Parses a YAML file into a nested array/Hash structure.

    See also: <CBA_fnc_dataPath>

Parameters:
    _file - Name of Yaml formatted file to parse <STRING>.

Returns:
    Data structure taken from the file, or nil if file had syntax errors.

Author:
    Spooner
---------------------------------------------------------------------------- */
SCRIPT(parseYAML);

#include "\x\cba\addons\strings\script_strings.hpp"

#define YAML_MODE_STRING 0
#define YAML_MODE_ASSOC_KEY 1
#define YAML_MODE_ASSOC_VALUE 2
#define YAML_MODE_ARRAY 3

#define YAML_TYPE_UNKNOWN 0
#define YAML_TYPE_SCALAR 1
#define YAML_TYPE_ARRAY 2
#define YAML_TYPE_ASSOC 3

#define ASCII_YAML_COMMENT ASCII_HASH
#define ASCII_YAML_ASSOC ASCII_COLON
#define ASCII_YAML_ARRAY ASCII_MINUS
// -----------------------------------------------------------------------------

private _raiseError = {
    params ["_message", "_yaml", "_pos", "_lines"];

    private _lastLine = _lines select ((count _lines) - 1);
    private _lastChar = _lastLine select ((count _lastLine) - 1);

    _lastLine resize ((count _lastLine) - 1);

    _lastLine pushBack ASCII_VERTICAL_BAR;
    _lastLine pushBack ASCII_HASH;
    _lastLine pushBack ASCII_VERTICAL_BAR;
    _lastLine pushBack _lastChar;

    _pos = _pos + 1;
    while {_pos < (count _yaml)} do {
        _char = _yaml select _pos;

        if (_char in [ASCII_YAML_COMMENT, ASCII_CR, ASCII_NEWLINE]) exitWith {};

        _lastLine pushBack _char;

        _pos = _pos + 1;
    };

    private _errorBlock = "";

    for [{_i = 0 max ((count _lines) - 6)}, {_i < count _lines}, {_i = _i + 1}] do {
        _errorBlock = _errorBlock + format ["\n%1: %2", [_i + 1, 3] call CBA_fnc_formatNumber,
            toString (_lines select _i)];
    };

    _message = format ["%1, in ""%2"" at line %3:\n%4", _message,
        _file, count _lines, _errorBlock];

    ERROR_WITH_TITLE("CBA YAML parser error",_message);
};

private _parse = {
    params ["_yaml", "_pos", "_indent", "_lines"];

    private _error = false;
    private _currentIndent = _indent max 0;
    private _key = [];
    private _value = [];
    private _return = false;
    private _mode = YAML_MODE_STRING;
    private _dataType = YAML_TYPE_UNKNOWN;
    private "_data"; //is initially undefined.

    while {_pos < ((count _yaml) - 1) && !_error && !_return} do {
        _pos = _pos + 1;
        _char = _yaml select _pos;

        if (_char == ASCII_YAML_COMMENT) then {
            // Trim comments.
            while {!(_char in _lineBreaks)} do {
                _pos = _pos + 1;
                _char = _yaml select _pos;
            };

            _pos = _pos - 1; // Parse the newline normally.
        } else {
            if (_char in _lineBreaks) then {
                _currentIndent = 0;
                _lines pushBack [];
            } else {
                (_lines select ((count _lines) - 1)) pushBack _char;
            };

            switch (_mode) do {
                case YAML_MODE_ARRAY: {
                    if (_char in _lineBreaks) then {
                        _value = [toString _value] call CBA_fnc_trim;

                        // If remainder of line is blank, assume
                        // multi-line data.
                        if (([_value] call CBA_fnc_strLen) == 0) then {
                            private _retVal = ([_yaml, _pos, _currentIndent, _lines] call _parse);

                            _pos = _retVal select 0;
                            _value = _retVal select 1;
                            _error = _retVal select 2;
                        };

                        if !(_error) then {
                            //IGNORE_PRIVATE_WARNING ["_data"];
                            _data pushBack _value;
                            _mode = YAML_MODE_STRING;
                        };
                    } else {
                        _value pushBack _char;
                    };
                };
                case YAML_MODE_ASSOC_KEY: {
                    if (_char in _lineBreaks) then {
                        ["Unexpected new-line, when expecting ':'", _yaml, _pos, _lines] call _raiseError;
                        _error = true;
                    } else {
                        switch (_char) do {
                            case ASCII_YAML_ASSOC: {
                                _key = [toString _key] call CBA_fnc_trim;
                                _mode = YAML_MODE_ASSOC_VALUE;
                            };
                            default {
                                _key pushBack _char;
                            };
                        };
                    };
                };
                case YAML_MODE_ASSOC_VALUE: {
                    if (_char in _lineBreaks) then {
                        _value = [toString _value] call CBA_fnc_trim;

                        // If remainder of line is blank, assume
                        // multi-line data.
                        if (([_value] call CBA_fnc_strLen) == 0) then {
                            private _retVal = ([_yaml, _pos, _currentIndent, _lines] call _parse);

                            _pos = _retVal select 0;
                            _value = _retVal select 1;
                            _error = _retVal select 2;
                        };

                        if !(_error) then {
                            //TRACE_1("Added Hash element",_value);
                            [_data, _key, _value] call CBA_fnc_hashSet;
                            _mode = YAML_MODE_STRING;
                        };
                    } else {
                        _value pushBack _char;
                    };
                };
                case YAML_MODE_STRING: {
                    switch (_char) do {
                        case ASCII_CR: {
                            // Already dealt with.
                        };
                        case ASCII_NEWLINE: {
                            // Already dealt with.
                        };
                        case ASCII_SPACE: {
                            _currentIndent = _currentIndent + 1;
                        };
                        case ASCII_TAB: {
                            ["Tab character not allowed for indenting YAML; use spaces instead", _yaml, _pos, _lines] call _raiseError;
                            _error = true;
                        };
                        case ASCII_YAML_ASSOC: {
                            ["Can't start a line with ':'", _yaml, _pos, _lines] call _raiseError;
                            _error = true;
                        };
                        case ASCII_YAML_ARRAY: {
                            if (_currentIndent > _indent) then {
                                if (_dataType == YAML_TYPE_UNKNOWN) then {
                                    _data = [];
                                    _dataType = YAML_TYPE_ARRAY;

                                    _indent = _currentIndent;

                                    _value = [];
                                    _mode = YAML_MODE_ARRAY;
                                } else {
                                    _error = true;
                                };
                            } else {
                                if (_currentIndent < _indent) then {
                                    // Ignore and pass down the stack.
                                    _pos = _pos - 1;
                                    _return = true;
                                } else {
                                    if (_dataType == YAML_TYPE_ARRAY) then {
                                        _value = [];
                                        _mode = YAML_MODE_ARRAY;
                                    } else {
                                        _error = true;
                                    };
                                };
                            };
                        };
                        default { // Anything else must be the start of an associative key.
                            if (_currentIndent > _indent) then {
                                if (_dataType == YAML_TYPE_UNKNOWN) then {
                                    _data = [] call CBA_fnc_hashCreate;
                                    _dataType = YAML_TYPE_ASSOC;

                                    _indent = _currentIndent;

                                    _key = [_char];
                                    _value = [];
                                    _mode = YAML_MODE_ASSOC_KEY;
                                } else {
                                    _error = true;
                                };
                            } else {
                                if (_currentIndent < _indent) then {
                                    // Ignore and pass down the stack.
                                    _pos = _pos - 1;
                                    _return = true;
                                } else {
                                    if (_dataType == YAML_TYPE_ASSOC) then {
                                        _key = [_char];
                                        _value = [];
                                        _mode = YAML_MODE_ASSOC_KEY;
                                    } else {
                                        _error = true;
                                    };
                                };
                            };
                        };
                    };
                };
            };
        };
    };

    [_pos, _data, _error]; // Return.
};

// ----------------------------------------------------------------------------

params ["_file"];

private _yamlString = loadFile _file;
private _yaml = toArray _yamlString;
private _lineBreaks = [ASCII_NEWLINE, ASCII_CR];

// Ensure input ends with a newline.
if (count _yaml > 0) then
{
    if !((_yaml select ((count _yaml) - 1)) in _lineBreaks) then {
        _yaml pushBack ASCII_NEWLINE;
    };
};

_pos = -1;

_retVal = ([_yaml, _pos, -1, [[]]] call _parse);
_pos = _retVal select 0;
_value = _retVal select 1;
_error = _retVal select 2;

if (_error) then {
    nil // Return.
} else {
    _value // Return.
};
