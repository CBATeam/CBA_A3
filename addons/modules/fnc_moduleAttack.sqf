/* ----------------------------------------------------------------------------
Function: CBA_fnc_moduleAttack

Description:
    A function for commanding a group to attack a location with information
    parsed from a module.

Parameters:
    Logic Parameters (Must be passed associated with Object using "setVariable")
    - Location Type (Scalar)
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

private ["_groups","_localGroups","_logic","_attackLocType","_attackPos","_searchRadius"];

// Only server, dedicated, or headless beyond this point
if (hasInterface && !isServer) exitWith {};

_groups = param [1,[],[[]]];
_localGroups = [];

{
    // Find owner of unit if headless client is present
    if (local _x) then {
        _localGroups pushBack _x;
    };
} forEach _groups;
if (count _localGroups == 0) exitWith {};

// Define variables
_logic = param [0];
_attackLocType = _logic getVariable "attackLocType";
_attackPos = _logic getVariable "attackPosition";

// Parse attack position from string
_attackPos = [_attackLocType, _attackPos] call CBA_fnc_getStringPos;
if (_attackPos isEqualTo 0) then {_attackPos = getPos _logic;};

// Set attack for local units
_searchRadius = _logic getVariable "searchRadius";

// Assign attack to group leaders
{
    [_x, _attackPos, _searchRadius] call CBA_fnc_taskAttack;
} forEach _localGroups;
