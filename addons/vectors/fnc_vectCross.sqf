/* ----------------------------------------------------------------------------
Function: CBA_fnc_vectCross

Description:
 Returns the cross product vector of two vectors.  Vectors must both be three dimensional.

Parameters:
 _u the first vector.
 _v the second vector.

Returns:
 the cross product (vector) of the two vectors.

Examples:
	(begin example)

	(end)

Author:
	Vigilante, courtesy by -=ACE=- of Simcentric
---------------------------------------------------------------------------- */
scriptName "fnc_vectCross.sqf";

#include "script_component.hpp"
SCRIPT(vectCross);


 private ["_u","_v","_i","_k", "_j"];

PARAMS_2(_u,_v);

_i = ((_u select 1) * (_v select 2)) - ((_u select 2) * (_v select 1));
_k = ((_u select 2) * (_v select 0)) - ((_u select 0) * (_v select 2));
_j = ((_u select 0) * (_v select 1)) - ((_u select 1) * (_v select 0));

[_i, _k, _j];