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

//SCRIPT(moduleDefend);

private["_logic","_units","_localUnits","_defendPos","_defendLocType","_defendRadius","_defendSetPos","_threshold","_canPatrol"];

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
_defendLocType = _logic getVariable "defendLocType";
_defendPos = _logic getVariable "defendPosition";
_defendSetPos = false;

// Parse defend position from string
_defendPos = [_defendLocType, _defendPos] call CBA_fnc_getStringPos;
if (_defendPos isEqualTo 0) then {_defendSetPos = true;};

// Define if allowed to patrol
_canPatrol = _logic getVariable "canPatrol";
switch (_canPatrol) do {
    case 0: {_canPatrol = false;};
    default {_canPatrol = true;};
};

// Command local units to defend area
_defendRadius = _logic getVariable "defendRadius";
_threshold = _logic getVariable "threshold";
{
    if (_defendSetPos) then {_defendPos = getPos _x;};
    [_x, _defendPos, _defendRadius, _threshold, _canPatrol] call CBA_fnc_taskDefend;
} forEach _localUnits;
