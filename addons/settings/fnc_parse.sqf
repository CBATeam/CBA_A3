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
    commy2, johnb43
---------------------------------------------------------------------------- */

params [["_info", "", [""]], ["_validate", false, [false]], ["_source", "", [""]]];

// Parses bools, numbers, strings
private _fnc_parseAny = {
    params ["_string"];

    // Remove whitespace so parseSimpleArray can handle arrays.
    // Means that strings inside arrays don't support white space chars, but w/e.
    // No such setting exists atm anyway.
    _string = _string splitString _whitespace joinString "";

    parseSimpleArray (["[", _string, "]"] joinString "") select 0
};

// Remove whitespaces at the start and end of each statement, a statement being defined by the ";" at its end
private _parsed = [];

{
    _parsed pushBack (trim _x);
} forEach (_info splitString ";");

// Remove empty strings
_parsed = _parsed - [""];

// Separate statements (setting = value)
private _result = [];
private _indexEqualSign = -1;
private _setting = "";
private _priority = 0;
private _value = "";
private _countForce = count "force";
private _whitespace = WHITESPACE;

{
    _indexEqualSign = _x find "=";

    // Setting name is in front of "="
    _setting = (_x select [0, _indexEqualSign]) trim [_whitespace, 2];
    _priority = 0;

    // Check if the first entry is "force" and not followed by whitespace
    if (_setting select [0, _countForce] == "force" && {(_setting select [_countForce, 1]) in _whitespace}) then {
        _setting = (_setting select [_countForce]) trim [_whitespace, 1];
        _priority = _priority + 1;
    };

    // Check if the second entry is "force" and not followed by whitespace
    if (_setting select [0, _countForce] == "force" && {(_setting select [_countForce, 1]) in _whitespace}) then {
        _setting = (_setting select [_countForce]) trim [_whitespace, 1];
        _priority = _priority + 1;
    };

    // If setting is valid, get its value
    if (_setting != "") then {
        _value = (_x select [_indexEqualSign + 1]) call _fnc_parseAny;

        if !(_validate) then {
            _result pushBack [_setting, _value, _priority];
        } else {
            // Check if setting is valid
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
} forEach _parsed;

_result
