#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_parse

Description:
    Convert settings in file format into array.

Parameters:
    _info     - Content of file or clipboard to parse. <STRING>
    _validate - Check if settings are valid. (optional, default: false) <BOOL>

Returns:
    Settings with values and priority states. <ARRAY>

Author:
    commy2
---------------------------------------------------------------------------- */

// parses bool, number, string
private _fnc_parseAny = {
    params ["_string"];

    // Remove whitespace so parseSimpleArray can handle arrays.
    // Means that strings inside arrays don't support white space chars, but w/e.
    // No such setting exists atm anyway.
    if (_string find """" != 0) then {
        _string = _string splitString WHITESPACE joinString "";
    };

    parseSimpleArray format ["[%1]", _string] select 0
};

params [["_info", "", [""]], ["_validate", false, [false]], ["_source", "", [""]]];

// remove whitespace at start and end of each line
private _result = [];

{
    _result pushBack (_x call CBA_fnc_trim);
} forEach (_info splitString NEWLINE);

{
    if (_x select [count _x - 1] != ";") then {
        _result set [_forEachIndex, _x + ";"];
    };
} forEach _result;

_info = (_result joinString NEWLINE) + NEWLINE;

// separate statements (setting = value)
_result = [];

{
    private _indexEqualSign = _x find "=";

    private _setting = (_x select [0, _indexEqualSign]) call CBA_fnc_rightTrim;
    private _value = ((_x select [_indexEqualSign + 1]) call CBA_fnc_trim) call _fnc_parseAny;
    private _priority = 0;

    if (_setting select [0, count "force"] == "force") then {
        _setting = _setting select [count "force"] call CBA_fnc_leftTrim;
        _priority = _priority + 1;
    };

    if (_setting select [0, count "force"] == "force") then {
        _setting = _setting select [count "force"] call CBA_fnc_leftTrim;
        _priority = _priority + 1;
    };

    if (_setting != "") then {
        if !(_validate) then {
            _result pushBack [_setting, _value, _priority];
        } else {
            if (isNil {[_setting, "default"] call FUNC(get)}) exitWith {
                ERROR_1("Setting %1 does not exist.",_setting);
            };

            if !([_setting, _value] call FUNC(check)) exitWith {
                ERROR_2("Value %1 is invalid for setting %2.",TO_STRING(_value),_setting);
            };

            _priority = SANITIZE_PRIORITY(_setting,_priority,_source);
            _result pushBack [_setting, _value, _priority];
        };
    };
} forEach ([_info, ";" + NEWLINE] call CBA_fnc_split);

_result
