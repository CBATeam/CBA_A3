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

// Remove whitespace at start and end of each line, a line being define by the ";" at its end
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
private _whitespaces = [toString [ASCII_NEWLINE], toString [ASCII_CARRIAGE_RETURN], toString [ASCII_TAB], toString [ASCII_SPACE]];

{
    _indexEqualSign = _x find "=";

    // Setting name is front of "="
    _setting = (_x select [0, _indexEqualSign]) trim [WHITESPACE, 2];
    _priority = 0;

    // Check if the first entry is force and not followed by an empty space
    if (_setting select [0, _countForce] == "force" && {(_setting select [_countForce, 1]) in _whitespaces}) then {
        _setting = (_setting select [_countForce]) trim [WHITESPACE, 1];
        _priority = _priority + 1;
    };

    // Check if the second entry is force and not followed by an empty space
    if (_setting select [0, _countForce] == "force" && {(_setting select [_countForce, 1]) in _whitespaces}) then {
        _setting = (_setting select [_countForce]) trim [WHITESPACE, 1];
        _priority = _priority + 1;
    };

    // If setting is valid, get it's value
    if (_setting != "") then {
        // Remove whitespaces; Parse bool, number, string
        _value = parseSimpleArray (["[", (_x select [_indexEqualSign + 1]) splitString WHITESPACE joinString "", "]"] joinString "") select 0;

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
