/* ----------------------------------------------------------------------------
Function: CBA_fnc_vectRotate2D

Description:
	Rotates a 2D vector around a given center

Parameters:
	Center, Vector, Angle

Returns:
	The rotated vector

Author:
	Rommel
---------------------------------------------------------------------------- */

#include "script_component.hpp"

PARAMS_3(_center,_vector,_angle);
EXPLODE_2(_center,_x,_y);

private ["_dx","_dy"];
_dx = _x - (_vector select 0);
_dy = _y - (_vector select 1);	

[
	_x - ((_dx* cos(_angle)) - (_dy* sin(_angle))),
	_y - ((_dx* sin(_angle)) + (_dy* cos(_angle)))
]