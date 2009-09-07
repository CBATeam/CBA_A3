/* ----------------------------------------------------------------------------
Function: CBA_fnc_scaleVect

Description:
 scales a specified vector by a specified factor.

Parameters:
 _vect the vector to scale.
 _factor the scale factor.

Returns:
 a vector in the form [x, z, y] which represents the scaled initial vector.

Examples:
	(begin example)

	(end)

Author:
	Vigilante, courtesy by -=ACE=- of Simcentric
---------------------------------------------------------------------------- */
scriptName "fnc_scaleVect.sqf";

#include "script_component.hpp"
SCRIPT(scaleVect);


 private ["_vect","_factor","_i","_k", "_j"];

PARAMS_2(_vect,_factor);

_i = _factor * (_vect select 0);
_k = _factor * (_vect select 1);
_j = _factor * (_vect select 2);

[_i, _k, _j];