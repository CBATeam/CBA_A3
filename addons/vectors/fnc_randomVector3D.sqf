#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_randomVector3D

Description:
    Returns a 3 dimensional unit vector that is pointing in a random direction.

Parameters:
    Nothing

Returns:
    Unit vector in random direction <ARRAY>

Examples:
    (begin example)
        vectorMagnitude call CBA_fnc_randomVector3D // 1
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

[1, random 360, acos (random 2 - 1)] call CBA_fnc_polar2vect // return
