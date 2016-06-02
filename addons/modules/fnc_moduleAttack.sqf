/* ----------------------------------------------------------------------------
Function: CBA_fnc_moduleAttack

Description:
    A function for commanding a group to attack a location with information
    parsed from a module.

Parameters:
    Logic Parameters (Must be passed associated with Object using "setVariable")
    - Location Type (String)
        setVariable ["attackLocType", value]
    
    Group Parameter
    - Group Leader(s) (Array)

Optional:
    - Attack Position (XYZ, Object, Location, Group, Marker, or Task)
        setVariable ["attackPosition", value]
    - Search Radius (Scalar)
        setVariable ["searchRadius", value]

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
    "_searchRadius"
];

// Only server, dedicated, or headless beyond this point
if (hasInterface && !isServer) exitWith {};

_localGroups = [];

{
    // Find owner of unit if headless client is present
    if (local _x) then {
        _localGroups pushBack _x;
    };
} forEach _groups;

if (_localGroups isEqualTo []) exitWith {};

// Define variables
_attackLocType = _logic getVariable "attackLocType";
_attackPos = _logic getVariable "attackPosition";

// Parse attack position from string
_attackPos = [_attackLocType, _attackPos] call CBA_fnc_getStringPos;
if (isNil "_attackPos") then {_attackPos = getPos _logic;};

// Set attack for local units
_searchRadius = _logic getVariable "searchRadius";

// Assign attack to group leaders
{
    [_x, _attackPos, _searchRadius] call CBA_fnc_taskAttack;
} forEach _localGroups;
