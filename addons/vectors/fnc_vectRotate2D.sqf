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

EXPLODE_2(_center,_x2,_y2);

private ["_tvector","_tangle"];
_tvector = _vector;
_tangle = _angle;

while{_tangle < 0} do {_tangle = _tangle + 360};	
while {_tangle > 0} do {
	_angle = _tangle min 90;
	_tangle = _tangle - 90;
	
	private ["_dx","_dy"];
	_dx = _x2 - (_tvector select 0);
	_dy = _y2 - (_tvector select 1);	
	
	_x = _x2 - ((_dx* cos(_angle)) - (_dy* sin(_angle)));
	_y = _y2 - ((_dx* sin(_angle)) + (_dy* cos(_angle)));
	_tvector = [_x,_y];
};
_tvector