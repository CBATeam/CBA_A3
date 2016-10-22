/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_clear

Description:
    Clear all settings from profile or mission.

Parameters:
    _source - Can be "client", "mission" or "server" (optional, default: "client") <STRING>

Returns:
    None

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [["_source", "client", [""]]];

switch (toLower _source) do {
    case "client": {
        if (isServer) exitWith {
            "server" call FUNC(clear);
        };

        profileNamespace setVariable [QGVAR(hash), HASH_NULL];
        GVAR(client) call CBA_fnc_deleteNamespace;
        GVAR(client) = [] call CBA_fnc_createNamespace;

        {
            private _setting = _x;

            if (!isNil {GVAR(userconfig) getVariable _setting}) then {
                (GVAR(userconfig) getVariable _setting) params ["_value", ["_priority", 0]];

                if !([_setting, _value] call FUNC(check)) then {
                    _value = [_setting, "default"] call FUNC(get);
                };

                // convert boolean to number
                _priority = [0,1,2] select _priority;

                GVAR(client) setVariable [_setting, [_value, _priority min 0]];
            };
        } forEach GVAR(allSettings);
    };
    case "mission": {
        if (!is3DEN) exitWith {};

        set3DENMissionAttributes [["Scenario", QGVAR(hash), HASH_NULL]];
        GVAR(mission) call CBA_fnc_deleteNamespace;
        GVAR(mission) = [] call CBA_fnc_createNamespace;

        {
            private _setting = _x;

            if (!isNil {GVAR(missionConfig) getVariable _setting}) then {
                (GVAR(missionConfig) getVariable _setting) params ["_value", ["_priority", 0]];

                if !([_setting, _value] call FUNC(check)) then {
                    _value = [_setting, "default"] call FUNC(get);
                };

                // convert boolean to number
                _priority = [0,1,2] select _priority;

                GVAR(mission) setVariable [_setting, [_value, _priority min 1]];
            };
        } forEach GVAR(allSettings);
    };
    case "server": {
        if (!isServer) exitWith {};

        profileNamespace setVariable [QGVAR(hash), HASH_NULL];
        GVAR(client) call CBA_fnc_deleteNamespace;
        GVAR(client) = [] call CBA_fnc_createNamespace;
        GVAR(server) call CBA_fnc_deleteNamespace;
        missionNamespace setVariable [QGVAR(server), true call CBA_fnc_createNamespace, true];

        {
            private _setting = _x;

            if (!isNil {GVAR(userconfig) getVariable _setting}) then {
                (GVAR(userconfig) getVariable _setting) params ["_value", ["_priority", 0]];

                if !([_setting, _value] call FUNC(check)) then {
                    _value = [_setting, "default"] call FUNC(get);
                };

                // convert boolean to number
                _priority = [0,1,2] select _priority;

                GVAR(client) setVariable [_setting, [_value, _priority min 0]];
                GVAR(server) setVariable [_setting, [_value, _priority min 2], true];
            };
        } forEach GVAR(allSettings);
    };
    default {};
};

if (isServer) then {
    QGVAR(refreshAllSettings) call CBA_fnc_globalEvent;
} else {
    QGVAR(refreshAllSettings) call CBA_fnc_localEvent;
};

nil
