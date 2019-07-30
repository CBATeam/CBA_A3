#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_vectElev

Description:
 Returns the angle of elevation of a 3D vector with the given i, j and k coordinates in the range -90 to 90.

Parameters:
 _vect the 3D vector in the form [i, k, j].

Returns:
 the corresponding angle of elevation in range -90 to 90.

Examples:
    (begin example)

    (end)

Author:
    Vigilante, courtesy by -=ACE=- of Simcentric
---------------------------------------------------------------------------- */

SCRIPT(vectElev);

params ["_pos1", "_pos2"];

private _dist2D = (_this) call CBA_fnc_vectMagn2D;

(_this select 2) atan2 _dist2D;
