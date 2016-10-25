/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_parse

Description:
    Copy all setting info into clipboard.

Parameters:
    _info - Content of file or clipboard to parse. <STRING>

Returns:
    Settings with values and forced states. <ARRAY>

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

#define ASCII_NEWLINE 10
#define ASCII_CARRIAGE_RETURN 13
#define ASCII_TAB 9
#define ASCII_SPACE 32

#define WHITE_SPACE [ASCII_NEWLINE, ASCII_CARRIAGE_RETURN, ASCII_TAB, ASCII_SPACE]

#define KEYWORD_FORCE "force"
#define QUOTE_MARKS toArray """'"
#define ALL_NUMBERS toArray "0123456789"
#define ASCII_ARRAY_OPEN (toArray "[" select 0)
#define ASCII_ARRAY_CLOSE (toArray "]" select 0)

private _fnc_parseArray = {
    params [["_array", "", [""]]];
    _array = _array call CBA_fnc_trim;

    if ((_array select [0,1]) isEqualTo "[" && {(_array select [count _array - 1]) isEqualTo "]"}) then {
        _array = (_array select [1, count _array - 2]) splitString ",";

        // parse numbers and strings
        _array = _array apply {
            _x = _x call CBA_fnc_trim;

            if ((_x select [0,1]) isEqualTo """") then {
                _x select [1, count _x - 2]
            } else {
                parseNumber _x;
            };
        };

        _array
    } else {
        []
    };
};

params [["_info", "", [""]]];

private _result = [];

{
    private _statement = _x;

    private _force = false;
    if ((_statement splitString toString WHITE_SPACE) param [0, ""] == KEYWORD_FORCE) then {
        _force = true;
        _statement = _statement select [(toLower _statement find KEYWORD_FORCE) + count KEYWORD_FORCE];
    };

    _setting = (_statement select [0, _statement find "="]) call CBA_fnc_trim;
    _value = (_statement select [(_statement find "=") + 1]) call CBA_fnc_trim;

    if (_setting != "") then {
        private _value0 = toArray (_value select [0,1]) select 0;
        private _valueE = toArray (_value select [count _value - 1]) select 0;

        _value = switch (true) do {
        //--- boolean
        case (_value == "true"): {
            true
        };
        case (_value == "false"): {
            false
        };
        //--- number
        case (_value0 in ALL_NUMBERS): {
            parseNumber _value
        };
        //--- string
        case (_value0 in QUOTE_MARKS && {_valueE in QUOTE_MARKS}): {
            _value select [1, count _value - 2]
        };
        //--- array
        case (_value0 == ASCII_ARRAY_OPEN && {_valueE == ASCII_ARRAY_CLOSE}): {
            _value call _fnc_parseArray
        };
        default {nil};
        };

        private _currentValue = [_setting, "default"] call FUNC(get);

        if (isNil "_currentValue") then {
            ERROR_1("Error parsing settings file. Setting %1 does not exist.",str _setting);
        } else {
            if ([_setting, _value] call FUNC(check)) then {
                _result pushBack [_setting, _value, _force];
            } else {
                ERROR_2("Error parsing settings file. Value %1 is invalid for setting %2.",_value,str _setting);
            };
        };
    };
} forEach (_info splitString ";");

_result
