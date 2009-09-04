/* ----------------------------------------------------------------------------
Function: CBA_fnc_vectAdd

Description:
 Returns the sum of two vectors.  Vectors can be 2D or 3D

Parameters:
 _u the the first vector
 _v the the first vector

Returns:
 the sum of the two vectors.

Examples:
	(begin example)

	(end)

Author:
	Vigilante, courtesy by -=ACE=- of Simcentric
---------------------------------------------------------------------------- */
scriptName "fnc_vectAdd.sqf";

#include "script_component.hpp"
SCRIPT(vectAdd);

private ["_u","_v","_i","_k", "_j"];

_u = _this select 0;
_v = _this select 1;

_i = (_u select 0) + (_v select 0);
_k = (_u select 1) + (_v select 1);
_j = (_u select 2) + (_v select 2);

[_i, _k, _j];