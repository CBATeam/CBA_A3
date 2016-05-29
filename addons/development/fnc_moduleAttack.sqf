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

//#include "script_component.hpp"
//SCRIPT(moduleAttack);

private ["_logic","_units","_localUnits","_attackLocType","_attackPos","_searchRadius"];

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

// Parse attack position from string
_logic = param [0];
_attackLocType = _logic getVariable "attackLocType";
_attackPos = _logic getVariable "attackPosition";

switch (_attackLocType) do {
    case "array": {_attackPos = [_attackPos] call BIS_fnc_parseNumber;};
    case "object": {_attackPos = getPos (call compile _attackPos);};
    case "group": {_attackPos = getPos (leader(call compile _attackPos));};
    case "marker": {_attackPos = getMarkerPos _attackPos;};
    default {_attackPos = getPos _logic;};
};

// Set attack for local units
_searchRadius = _logic getVariable "searchRadius";

{
    [_x, _attackPos, _searchRadius] call CBA_fnc_taskAttack;
} forEach _localUnits;
