/* ----------------------------------------------------------------------------
Function: CBA_fnc_vect2Polar

Description:

Parameters:

Returns:

Examples:
    (begin example)

    (end)

Author:
    Vigilante, courtesy by -=ACE=- of Simcentric
---------------------------------------------------------------------------- */
scriptName "fnc_vect2Polar.sqf";

#include "script_component.hpp"
SCRIPT(vect2Polar);


 private ["_mag", "_dir", "_elev", "_vx", "_vy", "_vz"];

PARAMS_3(_vx,_vy,_vz);

_mag = _this call BIS_fnc_magnitude;
_elev = if (_mag > 0) then { asin (_vz / _mag) } else { 0 };
_dir = _this call CBA_fnc_vectDir;

[_mag, _dir, _elev];
