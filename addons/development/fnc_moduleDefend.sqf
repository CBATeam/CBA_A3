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

// Parse defend position from string
_logic = param [0];
_defendLocType = _logic getVariable "defendLocType";
_defendPos = _logic getVariable "defendPosition";
_defendSetPos = false;

switch (_defendLocType) do {
    case "array": {_defendPos = [_defendPos] call BIS_fnc_parseNumber;};
    case "object": {_defendPos = getPos (call compile _defendPos);};
    case "group": {_defendPos = getPos (leader(call compile _defendPos));};
    case "marker": {_defendPos = getMarkerPos _defendPos;};
    case "module": {_defendPos = getPos _logic;};
    default {_defendSetPos = true;};
};

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
