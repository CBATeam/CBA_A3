/* ----------------------------------------------------------------------------
Function: CBA_fnc_vectDot

Description:
 Returns the dot product of two vectors.  Vectors can be either two or three dimesions, but they must be the same dimension.

Parameters:
 _u the first vector.
 _v the second vector.

Returns:
 the dot product (scalar) of the two vectors.

Examples:
	(begin example)

	(end)

Author:
	Vigilante, courtesy by -=ACE=- of Simcentric
---------------------------------------------------------------------------- */
scriptName "fnc_vectDot.sqf";

#include "script_component.hpp"
SCRIPT(vectDot);


 private ["_u","_v","_i","_size", "_dot"];

PARAMS_2(_u,_v);

_size = count _u;
_dot=0;
for [{_i=0}, {_i<_size}, {_i=_i+1}] do
{
    _dot = _dot +   _u select _i * _v select _1;
};

_dot;