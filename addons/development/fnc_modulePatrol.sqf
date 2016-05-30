/* ----------------------------------------------------------------------------
Function: CBA_fnc_moduleAttack

Description:
    A function for commanding a group to attack a location with information
    parsed from a module.

Parameters:
    - Group (Array of Classnames or an array of a config)
    - Spawn Point (XYZ, Object, Location or Marker)
    - Attack Point (XYZ, Object, Location, Group, or Marker)

Optional:
    - Attack Radius (Number)

Example:
    (begin example)
    (end)

Returns:
    Nil

Author:
    WiredTiger

---------------------------------------------------------------------------- */

//SCRIPT(modulePatrol);

private[
    "_logic",
    "_units",
    "_localUnits",
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

_units = param [1,[],[[]]];
_localUnits = [];

{
    // Find owner of unit if headless client is present
    if (local _x) then {
        _localUnits pushBack _x;
    };
} forEach _units;
if (count _localUnits == 0) exitWith {};

// Define variables
_logic = param [0];
_patrolLocType = _logic getVariable "patrolLocType";
_patrolPos = _logic getVariable "patrolPosition";
_patrolSetPos = false;

// Parse patrol position from string
_patrolPos = [_patrolLocType, _patrolPos] call CBA_fnc_getStringPos;
if (_patrolPos isEqualTo 0) then {_patrolSetPos = true;};

// Parse timeout using getStringPos
_timeout = _logic getVariable "timeout";
_timeout = [3,_timeout] call CBA_fnc_getStringPos;

// Define remaining variables and command local units to patrol area
_patrolRadius = _logic getVariable "patrolRadius";
_waypointCount = _logic getVariable "waypointCount";
_waypointType = _logic getVariable "waypointType";
_behaviour = _logic getVariable "behaviour";
_combatMode = _logic getVariable "combatMode";
_speedMode = _logic getVariable "speedMode";
_formation = _logic getVariable "formation";
_codeToRun = _logic getVariable "executableCode";
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
} forEach _localUnits;
