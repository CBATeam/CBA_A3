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

private _z = random 2 - 1;
private _r = sqrt (1 - _z^2);
private _theta = random 360;

[_r * cos _theta, _r * sin _theta, _z] // return
