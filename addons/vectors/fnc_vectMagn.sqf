#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_vectMagn

Description:
 Returns the magnitude of a 3D vector with the given i, j and k coordinates.

Parameters:
 _vect a 3D vector [i, k, j]

Returns:
 the magnitude of the vector.

Examples:
    (begin example)

    (end)

Author:
    Vigilante, courtesy by -=ACE=- of Simcentric
---------------------------------------------------------------------------- */

SCRIPT(vectMagn);

vectorMagnitude _this
