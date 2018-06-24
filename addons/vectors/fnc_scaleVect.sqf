#include "script_component.hpp"
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

SCRIPT(scaleVect);

params ["_vect", "_factor"];

_vect vectorMultiply _factor;
