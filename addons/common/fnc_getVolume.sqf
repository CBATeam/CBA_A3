/* ----------------------------------------------------------------------------
Function: CBA_fnc_getVolume

Description:
	Return the volume of an object

Parameters:

Returns:

Examples:
	(begin example)

	(end)

Author:
	Rommel
---------------------------------------------------------------------------- */

#include <script_component.hpp>

PARAMS_1(_object);

private ["_bX","_bA","_bB"];
_bX = boundingBox _object;
_bA = _bX select 0;
_bA = _bX select 1;

EXPLODE_3(_bA,_x1,_y1,_z1);
EXPLODE_3(_bB,_x2,_y2,_z2);
((_x1 + _x2) * (_y1 + _y2) * (_z1 + _z2));