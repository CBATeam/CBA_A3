/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_priority

Description:
    Check which source of the setting is set to the highest priority.

Parameters:
    _setting - Name of the setting <STRING>
    _source  - Can be "client", "mission", "server" or "priority" (optional, default: "priority") <STRING>

Returns:
    _source -
        If _source = "priority": source with highest priority <STRING>
        Otherwise: priority of given _source <NUMBER, BOOL>

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [["_setting", "", [""]], ["_source", "priority", [""]]];

private _isGlobal = GVAR(default) getVariable [_setting, []] param [7, 0];

switch (toLower _source) do {
    case "client": {
        (GVAR(client) getVariable [_setting, [nil, 0]] select 1) min 0
    };
    case "mission": {
        private _priority = (GVAR(mission) getVariable [_setting, [nil, 0]] select 1) min 1;

        if (_isGlobal isEqualTo 1) exitWith {
            _priority max 1
        };

        if (_isGlobal isEqualTo 2) exitWith {
            _priority min 0
        };

        _priority
    };
    case "server": {
        private _priority = (GVAR(server) getVariable [_setting, [nil, 0]] select 1) min 2;

        if (_isGlobal isEqualTo 1) exitWith {
            _priority max 1
        };

        if (_isGlobal isEqualTo 2) exitWith {
            _priority min 0
        };

        _priority
    };
    case "priority": {
        private _arr = [
            [_setting, "client"]  call FUNC(priority),
            [_setting, "mission"] call FUNC(priority),
            [_setting, "server"]  call FUNC(priority)
        ];
        ["client", "mission", "server"] select (_arr find selectMax _arr)
    };
    default {0};
};
