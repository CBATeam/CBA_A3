/* ----------------------------------------------------------------------------
Function: CBA_fnc_vectMagn2D

Description:
 Returns the magnitude of a vector with the given i and k coordinates or the magnitude of the i and k components of a 3D vector.

Parameters:
 _vect the 2D vector in the form [i,k] or a 3D vector in the form [i,k,j] (j is ignored).

Returns:
 the magnitude of the i,k components of the vector.

Examples:
    (begin example)

    (end)
*  @call sct_simplifyAngle.sqf

Author:
    Vigilante, courtesy by -=ACE=- of Simcentric
---------------------------------------------------------------------------- */
scriptName "fnc_vectMagn2D.sqf";

#include "script_component.hpp"
SCRIPT(vectMagn2D);

sqrt((_this select 0)^2 + (_this select 1)^2)
