/* ----------------------------------------------------------------------------
Function: CBA_fnc_moduleAttack

Description:
    A function for commanding a group to attack a location with information
    parsed from a module.

Parameters:
    - Logic (Object)
    - Group Leader(s) (Array)

Optional:
    Logic Parameters (Must be passed associated with Object using "setVariable")
    - Location Type (String)
        setVariable ["attackLocType", value]
    - Attack Position (XYZ, Object, Location, Group, Marker, or Task)
        setVariable ["attackPosition", value]
    - Search Radius (Scalar)
        setVariable ["searchRadius", value]
    - Allow Override (Bool)
        setVariable ["allowOverride", value]

Example:
    (begin example)
    [Logic, [group1,group2,...,groupN]] call CBA_fnc_moduleAttack;
    (end)

Returns:
    Nil

Author:
    WiredTiger

---------------------------------------------------------------------------- */

#include "script_component.hpp"

params [
    ["_logic",objNull,[objNull]],
    ["_groups",[],[[]]],
    "_localGroups",
    "_logic",
    "_attackLocType",
    "_attackPos",
    "_searchRadius",
    "_allowOverride"
];

// Only server, dedicated, or headless beyond this point
if (hasInterface && !isServer) exitWith {};

_localGroups = _groups select { local _x };

if (_localGroups isEqualTo []) exitWith {};

// Define variables
_attackLocType = _logic getVariable ["attackLocType",""];
_attackPos = _logic getVariable ["attackPosition",objNull];

// Parse attack position from string
_attackPos = [_attackLocType, _attackPos] call CBA_fnc_getPosFromString;
if (isNil "_attackPos") then {_attackPos = getPos _logic;};

// Set final variables
_searchRadius = _logic getVariable ["searchRadius",0];
_allowOverride = _logic getVariable ["allowOverride",false];

// Set group(s) to attack
{
    [_x, _attackPos, _searchRadius, _allowOverride] call CBA_fnc_taskAttack;
} forEach _localGroups;
