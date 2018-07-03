#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_whitelisted

Description:
    Check if local machine can edit server settings.

Parameters:
    None.

Returns:
    _return - Can change server settings? <BOOL>

Examples:
    (begin example)
        [] call CBA_settings_fnc_whitelisted
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

private _uid = getPlayerUID player;
private _whitelist = getArray (configFile >> QGVAR(whitelist));

private _cfgMissionList = missionConfigFile >> QGVAR(whitelist);
if (isArray _cfgMissionList) then {
    _whitelist append getArray _cfgMissionList;
};

// if neither addon nor mission have white list, use wildcard for admin instead
if (_whitelist isEqualTo []) then {
    _whitelist = ["admin"];
};

// admin wildcard and local machine is logged in admin
if ("admin" in _whitelist && {IS_ADMIN_LOGGED}) exitWith {true};

_uid in _whitelist
