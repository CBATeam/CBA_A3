/* ----------------------------------------------------------------------------
Function: CBA_fnc_vectMagn

Description:
 Returns the magnitude of a 3D vector with the given i, j and k coordinates.

Parameters:
 _vect a 3D vector [i,k,j]

Returns:
 the magnitude of the vector.

Examples:
	(begin example)

	(end)

Author:
	Vigilante, courtesy by -=ACE=- of Simcentric
---------------------------------------------------------------------------- */
scriptName "fnc_vectMagn.sqf";

#include "script_component.hpp"
SCRIPT(vectMagn);

(sqrt((_this select 0)^2 + (_this select 1)^2 + (_this select 2)^2)) call CBA_fnc_simplifyAngle;