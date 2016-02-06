/* ----------------------------------------------------------------------------
Function: CBA_fnc_vectRotate2D

Description:
    Rotates a 2D vector around a given center, for rotating of a vector from its origin, use BIS_fnc_rotateVector2D

Parameters:
    Center, Vector, Angle

Returns:
    The rotated vector

Author:
    Rommel
---------------------------------------------------------------------------- */

#include "script_component.hpp"

params ["_center","_vector","_angle"];
_center params ["_x","_y"];


private _dx = _x - (_vector select 0);
private _dy = _y - (_vector select 1);

[
    _x - ((_dx* cos(_angle)) - (_dy* sin(_angle))),
    _y - ((_dx* sin(_angle)) + (_dy* cos(_angle)))
]
