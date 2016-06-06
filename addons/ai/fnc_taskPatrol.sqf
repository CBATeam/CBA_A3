/* ----------------------------------------------------------------------------
Function: CBA_fnc_taskPatrol

Description:
    A function for a group to randomly patrol a parsed radius and location.

Parameters:
    - Group (Group or Object)

Optional:
    - Position (XYZ, Object, Location or Group)
    - Radius (Scalar)
    - Waypoint Count (Scalar)
    - Waypoint Type (String)
    - Behaviour (String)
    - Combat Mode (String)
    - Speed Mode (String)
    - Formation (String)
    - Code To Execute at Each Waypoint (String)
    - TimeOut at each Waypoint (Array [Min, Med, Max])

Example:
    (begin example)
    [this, getmarkerpos "objective1", 50] call CBA_fnc_taskPatrol
    [this, this, 300, 7, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN", "this call CBA_fnc_searchNearby", [3,6,9]] call CBA_fnc_taskPatrol;
    (end)

Returns:
    Nil

Author:
    Rommel

---------------------------------------------------------------------------- */

#include "script_component.hpp"

params ["_group", ["_position",[]], ["_radius",100], ["_count",3]];

_group = _group call CBA_fnc_getGroup;
if !(local _group) exitWith {}; // Don't create waypoints on each machine

_position = [_position,_group] select (_position isEqualTo []);
_position = _position call CBA_fnc_getPos;

// Clear existing waypoints first
[_group] call CBA_fnc_clearWaypoints;

private _this =+ _this;
switch (count _this) do {
    case 1 : {_this append [_position, _radius]};
    case 2 : {_this pushback _radius};
    default {};
};
if (count _this > 3) then {
    _this deleteAt 3;
};

// Store first WP to close loop later
private _wp = _this call CBA_fnc_addWaypoint;

for "_x" from 1 to (_count - 1) do {
    _this call CBA_fnc_addWaypoint;
};

// Close the patrol loop
_this set [1, getWPPos _wp];
_this set [2, 0];
_this set [3, "CYCLE"];
_this call CBA_fnc_addWaypoint;
