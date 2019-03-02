#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_polar2vect

Description:
 Creates a vector based on a inputted magnitude, direction and elevation

Parameters:
 _mag the magnitude of the vector to create
 _dir the direction of the vector to create
 _elev the elevation of the vector to create

Returns:
 a vector in the form [x, z, y].

Examples:
    (begin example)

    (end)

Author:
    Vigilante, courtesy by -=ACE=- of Simcentric
---------------------------------------------------------------------------- */

SCRIPT(polar2vect);

params ["_mag", "_dir", "_elev"];

private _magCosElev = _mag * cos (_elev);
[_magCosElev * sin (_dir), _magCosElev * cos (_dir), _mag * sin (_elev)];
