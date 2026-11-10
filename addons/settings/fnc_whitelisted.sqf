#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_whitelisted

Description:
    Check if local machine or a given client can edit server settings.

Parameters:
    _owner - Network ID of the client to check. Only works on the server.
             Negative number checks the local machine (optional, default: -1) <NUMBER>

Returns:
    _return - Can change server settings? <BOOL>

Examples:
    (begin example)
        [] call CBA_settings_fnc_whitelisted
    (end)
    (begin example)
        [remoteExecutedOwner] call CBA_settings_fnc_whitelisted
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

params [["_owner", -1, [0]]];

private _whitelist = getArray (configFile >> QGVAR(whitelist));

private _cfgMissionList = missionConfigFile >> QGVAR(whitelist);
if (isArray _cfgMissionList) then {
    _whitelist append getArray _cfgMissionList;
};

// if neither addon nor mission have white list, use wildcard for admin instead
if (_whitelist isEqualTo []) then {
    _whitelist = ["admin"];
};

private _adminWildcard = "admin" in _whitelist;

// local machine
if (_owner < 0) exitWith {
    // admin wildcard and local machine is logged in admin
    (_adminWildcard && {IS_ADMIN_LOGGED}) || {getPlayerUID player in _whitelist}
};

// remote client, admin state and user info are only available on the server
if (!isServer) exitWith {false};

// 0 is what remoteExecutedOwner returns outside of remote execution, it is never a client
if (_owner == 0) exitWith {false};

// admin wildcard and client is logged in (not voted) admin
if (_adminWildcard && {admin _owner == 2}) exitWith {true};

private _users = allUsers;
private _index = _users findIf {(getUserInfo _x) param [1, -1] == _owner};
if (_index == -1) exitWith {false};

private _uid = (getUserInfo (_users select _index)) param [2, ""];

_uid != "" && {_uid in _whitelist}
