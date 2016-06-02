/* ----------------------------------------------------------------------------
Function: CBA_fnc_moduleAttack

Description:
    A function for commanding a group to defend a location with information
    parsed from a module.

Parameters:
    Logic Parameters (Must be passed associated with Object using "setVariable")
    - Location Type (Scalar)
        setVariable ["defendLocType", value]

Optional:
    - Defend Position (XYZ, Object, Location, Group, Marker, or Task)
        setVariable ["defendPosition", value]
    - Building Threshold (Scalar)
        setVariable ["threshold", value]
    - Can Patrol (Bool)
        setVariable ["canPatrol", vaule]

Example:
    (begin example)
    [Logic, [group1, group2,..., groupN]] call CBA_fnc_moduleDefend
    (end)

Returns:
    Nil

Author:
    WiredTiger

---------------------------------------------------------------------------- */

#include "script_component.hpp"

private [
    "_logic",
    "_groups",
    "_localGroups",
    "_defendPos",
    "_defendLocType",
    "_defendRadius",
    "_defendSetPos",
    "_threshold",
    "_canPatrol"
];

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
_defendLocType = _logic getVariable "defendLocType";
_defendPos = _logic getVariable "defendPosition";
_defendSetPos = false;

// Parse defend position from string
_defendPos = [_defendLocType, _defendPos] call CBA_fnc_getStringPos;
if (_defendPos isEqualTo 0) then {_defendSetPos = true;};

// Define if allowed to patrol
_canPatrol = _logic getVariable "canPatrol";
if (_canPatrol isEqualTo 0) then {_canPatrol = false;}else{_canPatrol = true;};

// Command local group leaders to defend area
_defendRadius = _logic getVariable "defendRadius";
_threshold = _logic getVariable "threshold";
{
    if (_defendSetPos) then {_defendPos = getPos _x;};
    [_x, _defendPos, _defendRadius, _threshold, _canPatrol] call CBA_fnc_taskDefend;
} forEach _localGroups;
