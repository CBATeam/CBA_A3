#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_setServerRequest

Description:
    Server side handler for a client's request to change a server setting.
    Verifies that the sender is allowed to edit server settings, see CBA_settings_fnc_whitelisted.

    Must be remote executed on the server, the sender is identified via remoteExecutedOwner.
    Code running on the server should use CBA_settings_fnc_set with source "server" instead.

Parameters:
    _setting  - Name of the setting <STRING>
    _value    - Value of the setting <ANY>
    _priority - New setting priority (optional, default: 0) <NUMBER, BOOLEAN>
    _store    - Store changed setting in server profile (optional, default: false) <BOOLEAN>

Returns:
    _return - Success <BOOL>

Examples:
    (begin example)
        ["CBA_TestSetting", 1, 2, true] remoteExecCall ["CBA_settings_fnc_setServerRequest", 2]
    (end)

Author:
    commy2, CBA Team
---------------------------------------------------------------------------- */

if (!isServer) exitWith {false};

params [["_setting", "", [""]], "_value", ["_priority", 0, [false, 0]], ["_store", false, [false]]];

// 2 is the server itself. 0 is returned outside of remote execution and for headless clients, never trust it.
private _owner = remoteExecutedOwner;

if (_owner != 2 && {_owner < 3 || {!([_owner] call FUNC(whitelisted))}}) exitWith {
    WARNING_2("Rejected request to change server setting %1. Sender %2 is not whitelisted.",_setting,_owner);
    false
};

[_setting, _value, _priority, "server", _store] call FUNC(set)
