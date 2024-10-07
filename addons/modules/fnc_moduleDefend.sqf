#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_moduleDefend

Description:
    A function for commanding a group to defend a location with information
    parsed from a module.

Parameters:
    - Logic (Object)
    - Group Leader(s) (Array)

Optional:
    Logic Parameters (Must be passed associated with Object using "setVariable")
    - Location Type (String)
        setVariable ["defendLocType", value]
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

params [
    ["_logic", objNull, [objNull]],
    ["_groups", [], [[]]],
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

_localGroups = _groups select {local _x};

if (_localGroups isEqualTo []) exitWith {};

// Define variables
_defendLocType = _logic getVariable ["defendLocType", ""];
_defendPos = _logic getVariable ["defendPosition", objNull];
_defendSetPos = false;

// Parse defend position from string
_defendPos = [_defendLocType, _defendPos] call CBA_fnc_getPosFromString;
if (isNil "_defendPos") then {_defendSetPos = true;};

// Define if allowed to patrol
_canPatrol = _logic getVariable ["canPatrol", 0.1];
private _shouldHold = _logic getVariable ["shouldHold", 0];

// Command local group leaders to defend area
_defendRadius = _logic getVariable ["defendRadius", 25];
_threshold = _logic getVariable ["threshold", 2];
{
    if (_defendSetPos) then {_defendPos = getPos _x;};
    [_x, _defendPos, _defendRadius, _threshold, _canPatrol, _shouldHold] call CBA_fnc_taskDefend;
} forEach _localGroups;
