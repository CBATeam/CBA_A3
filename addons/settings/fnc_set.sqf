/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_set

Description:
    Set the value of a setting.

Parameters:
    _setting  - Name of the setting <STRING>
    _value    - Value of the setting <ANY>
    _priority - New setting priority <NUMBER, BOOLEAN>
    _source   - Can be "client", "mission" or "server" (optional, default: "client") <STRING>
    _store    - Store changed setting in profile or mission (optional, default: false) <BOOLEAN>

Returns:
    _return - Success <BOOL>

Examples:
    (begin example)
        ["CBA_TestSetting", 1] call CBA_settings_fnc_set
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

// prevent race conditions. function could be called from scheduled env.
if (canSuspend) exitWith {
    [FUNC(set), _this] call CBA_fnc_directCall;
};

params [["_setting", "", [""]], "_value", ["_priority", 0, [false, 0]], ["_source", "client", [""]], ["_store", false, [false]]];

if (isNil "_value") then {
    _value = [_setting, "default"] call FUNC(get);
};

if !([_setting, _value] call FUNC(check)) exitWith {
    WARNING_2("Value %1 is invalid for setting %2.",TO_STRING(_value),_setting);
    false
};

private _currentValue = [_setting, _source] call FUNC(get);
private _currentPriority = [_setting, _source] call FUNC(priority);

if (_value isEqualTo _currentValue && {_priority isEqualTo _currentPriority}) exitWith {
    WARNING_3("Value %1 and priority %2 are the same as previously for setting %3.",TO_STRING(_value),_priority,_setting);
    false
};

private _return = true;

switch (toLower _source) do {
    case "client": {
        GVAR(client) setVariable [_setting, [_value, _priority]];

        if (_store) then {
            if (!isNil {GVAR(userconfig) getVariable _setting}) exitWith {
                WARNING_1("Cannot change setting %1 defined in userconfig file.",_setting);
            };

            private _settingsHash = profileNamespace getVariable [QGVAR(hash), HASH_NULL];
            [_settingsHash, toLower _setting, [_value, _priority]] call CBA_fnc_hashSet;
            profileNamespace setVariable [QGVAR(hash), _settingsHash];
        };

        [QGVAR(refreshSetting), _setting] call CBA_fnc_localEvent;
    };
    case "mission": {
        GVAR(mission) setVariable [_setting, [_value, _priority]];

        if (_store) then {
            if (!is3DEN) exitWith {
                WARNING_1("Source is mission, but not in 3DEN editor. Setting: %1",_setting);
            };

            if (!isNil {GVAR(missionConfig) getVariable _setting}) exitWith {
                WARNING_1("Cannot change setting %1 defined in mission settings file.",_setting);
            };

            private _settingsHash = "Scenario" get3DENMissionAttribute QGVAR(hash);
            [_settingsHash, toLower _setting, [_value, _priority]] call CBA_fnc_hashSet;
            set3DENMissionAttributes [["Scenario", QGVAR(hash), _settingsHash]];
            findDisplay 313 setVariable [QGVAR(hash), _settingsHash];
        };

        [QGVAR(refreshSetting), _setting] call CBA_fnc_localEvent;
    };
    case "server": {
        if (isServer) then {
            GVAR(client) setVariable [_setting, [_value, _priority]];
            GVAR(server) setVariable [_setting, [_value, _priority], true];

            if (_store) then {
                if (!isNil {GVAR(serverConfig) getVariable _setting}) exitWith {
                    WARNING_1("Cannot change setting %1 defined in server config file.",_setting);
                };

                private _settingsHash = profileNamespace getVariable [QGVAR(hash), HASH_NULL];
                [_settingsHash, toLower _setting, [_value, _priority]] call CBA_fnc_hashSet;
                profileNamespace setVariable [QGVAR(hash), _settingsHash];
            };

            [QGVAR(refreshSetting), _setting] call CBA_fnc_globalEvent;
        } else {
            if (IS_ADMIN_LOGGED) then {
                [QGVAR(setSettingServer), [_setting, _value, _priority, _store]] call CBA_fnc_serverEvent;
            } else {
                WARNING_1("Source is server, but no admin access. Setting: %1",_setting);
                _return = false;
            };
        };
    };
    default {
        WARNING_2("Invalid source %1 for setting %2",_source,_setting);
        _return = false;
    };
};

_return
