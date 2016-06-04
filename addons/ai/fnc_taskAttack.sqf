/* ----------------------------------------------------------------------------
Function: CBA_fnc_taskAttack

Description:
    A function for a group to attack a parsed location.

Parameters:
    - Group (Group or Object)
    - Position (XYZ, Object, Location or Group)

Optional:
    - Search Radius (Scalar)

Example:
    (begin example)
    [group player, getpos (player findNearestEnemy player), 100] call CBA_fnc_taskAttack
    (end)

Returns:
    Nil

Author:
    Rommel

---------------------------------------------------------------------------- */

#include "script_component.hpp"

params ["_group","_position", ["_radius",0]];

_group = _group call CBA_fnc_getGroup;
if !(local _group) exitWith {}; // Don't create waypoints on each machine

[_group] call CBA_fnc_clearWaypoints; // Clear existing waypoints

[_group, _position, _radius, "SAD", "COMBAT", "RED"] call CBA_fnc_addWaypoint;
