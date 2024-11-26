#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_modulePatrol

Description:
    A function for commanding a group to patrol a location with information
    parsed from a module.

Parameters:
    - Logic (Object)
    - Group Leader(s) (Array)

Optional:
    Logic Parameters (Must be passed associated with Object using "setVariable")
    - Location Type (String)
        setVariable ["patrolLocType", value]
    - Patrol Center (XYZ, Object, Location, Marker, or Task)
        setVariable ["patrolPosition", value]
    - Patrol Radius (Scalar)
        setVariable ["patrolRadius", value]
    - Waypoint Count (Scalar)
        setVariable ["waypointCount", value]
    - Waypoint Type (String)
        setVariable ["waypointType", value]
    - Behaviour (String)
        setVariable ["behaviour", value]
    - Combast Mode (String)
        setVariable ["combatMode", value]
    - Speed Mode (String)
        setVariable ["speedMode", value]
    - Formation (String)
        setVariable ["formation", value]
    - Code to Execute at Each Waypoint (String)
        setVariable ["executableCode", value]
    - Timeout at each waypoint (Array in String "[Min,Med,Max]")
        setVariable ["timeout", value]

Example:
    (begin example)
    [Logic, [group1, group2, ..., groupN]] call CBA_fnc_modulePatrol;
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
    "_patrolPos",
    "_patrolRadius",
    "_waypointCount",
    "_waypointType",
    "_behaviour",
    "_combatMode",
    "_speedMode",
    "_formation",
    "_codeToRun",
    "_timeout"
];

// Only server, dedicated, or headless beyond this point
if (hasInterface && !isServer) exitWith {};

_localGroups = _groups select {local _x};

if (_localGroups isEqualTo []) exitWith {};

// Define variables
private _patrolLocType = _logic getVariable ["patrolLocType", ""];
_patrolPos = _logic getVariable ["patrolPosition", objNull];
private _patrolSetPos = false;

// Parse patrol position from string
_patrolPos = [_patrolLocType, _patrolPos] call CBA_fnc_getPosFromString;
if (isNil "_patrolPos") then {_patrolSetPos = true;};

// Parse timeout using getStringPos
_timeout = [_logic getVariable ["timeout", "[1, 5, 10]"]] call BIS_fnc_parseNumber;

// Define remaining variables and command local group leaders to patrol area
_patrolRadius = _logic getVariable ["patrolRadius", 25];
_waypointCount = _logic getVariable ["waypointCount", 4];
_waypointType = _logic getVariable ["waypointType", "MOVE"];
_behaviour = _logic getVariable ["behaviour", "CARELESS"];
_combatMode = _logic getVariable ["combatMode", "YELLOW"];
_speedMode = _logic getVariable ["speedMode", "LIMITED"];
_formation = _logic getVariable ["formation", "COLUMN"];
_codeToRun = _logic getVariable ["executableCode", ""];
{
    if (_patrolSetPos) then {_patrolPos = getPos _x;};
    [
        _x,
        _patrolPos,
        _patrolRadius,
        _waypointCount,
        _waypointType,
        _behaviour,
        _combatMode,
        _speedMode,
        _formation,
        _codeToRun,
        _timeout
    ] call CBA_fnc_taskPatrol;
} forEach _localGroups;
