/* ----------------------------------------------------------------------------
Function: CBA_fnc_polar2vect

Description:
 Creates a vector based on a inputted magnitude, direction and elevation

Parameters:
 _mag the magnitude of the vector to create
 _dir the direction of the vector to create
 _elev the elevation of the vector to create

Returns:
 a vector in the form [x,z,y].

Examples:
    (begin example)

    (end)

Author:
    Vigilante, courtesy by -=ACE=- of Simcentric
---------------------------------------------------------------------------- */
scriptName "fnc_polar2vect.sqf";

#include "script_component.hpp"
SCRIPT(polar2vect);


 private ["_mag", "_dir", "_elev", "_magCosElev", "_vx", "_vy", "_vz"];

PARAMS_3(_mag,_dir,_elev);

_magCosElev = _mag * cos(_elev);

_vx = _magCosElev * sin(_dir);
_vz = _magCosElev * cos(_dir);
_vy = _mag * sin(_elev);

[_vx, _vz, _vy];