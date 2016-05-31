/* ----------------------------------------------------------------------------
Function: CBA_fnc_moduleAttack

Description:
    A function for commanding a group to attack a location with information
    parsed from a module.

Parameters:
    - Group Leader(s) (Synced to module)
    - Attack Point (XYZ, Object, Location, Group, Marker, or Task)

Optional:
    - Attack Radius (Number)

Example:
    (begin example)
    [groupLeader, "[0,0,0]", 25] call CBA_fnc_moduleAttack;
    (end)

Returns:
    Nil

Author:
    WiredTiger

---------------------------------------------------------------------------- */

//#include "script_component.hpp"
//SCRIPT(moduleAttack);

private ["_units","_localUnits","_logic","_attackLocType","_attackPos","_searchRadius"];

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
} forEach _localUnits;
