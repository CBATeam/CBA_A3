/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_get

Description:
    Returns the value of a setting.

Parameters:
    _setting - Name of the setting <STRING>
    _source  - Can be "server", "mission", "client", "forced" or "default" (optional, default: "forced") <STRING>

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

params [["_setting", "", [""]], ["_source", "forced", [""]]];

private _value = switch (toLower _source) do {
    case "server": {
        GET_VALUE(serverSettings,_setting);
    };
    case "client": {
        GET_VALUE(clientSettings,_setting);
    };
    case "mission": {
        GET_VALUE(missionSettings,_setting);
    };
    case "default": {
        GET_VALUE(defaultSettings,_setting);
    };
    case "forced": {
        private _value = [_setting, "client"] call FUNC(get);

        if ([_setting, "mission"] call FUNC(getForced)) then {
            _value = [_setting, "mission"] call FUNC(get);
        };

        if ([_setting, "server"] call FUNC(getForced)) then {
            _value = [_setting, "server"] call FUNC(get);
        };

        if (isNil "_value") then {nil} else {_value};
    };
    default {
        _source = "default"; // exit
    };
};

if (isNil "_value") exitWith {
    // setting does not seem to exist
    if (_source == "default") exitWith {nil};

    [_setting, "default"] call FUNC(get);
};

// copy array to prevent overwriting
if (_value isEqualType []) then {+_value} else {_value}
