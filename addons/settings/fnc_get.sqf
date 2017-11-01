/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_get

Description:
    Returns the value of a setting.

Parameters:
    _setting - Name of the setting <STRING>
    _source  - Can be "client", "mission", "server", "priority" or "default" (optional, default: "priority") <STRING>

Returns:
    Value of the setting <ANY>

Examples:
    (begin example)
        _result = "CBA_TestSetting" call CBA_settings_fnc_get
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [["_setting", "", [""]], ["_source", "priority", [""]]];

private _value = switch (toLower _source) do {
    case "client": {
        GVAR(client) getVariable [_setting, [nil, nil]] select 0
    };
    case "mission": {
        GVAR(mission) getVariable [_setting, [nil, nil]] select 0
    };
    case "server": {
        GVAR(server) getVariable [_setting, [nil, nil]] select 0
    };
    case "priority": {
        private _source = _setting call FUNC(priority);
        [_setting, _source] call FUNC(get)
    };
    case "default": {
        GVAR(default) getVariable [_setting, [nil, nil]] select 0
    };
    default {
        _source = "default"; // exit
        nil
    };
};

if (isNil "_value") exitWith {
    // setting does not seem to exist
    if (_source == "default") exitWith {nil};

    [_setting, "default"] call FUNC(get);
};

// copy array to prevent accidental overwriting
if (_value isEqualType []) then {+_value} else {_value}
