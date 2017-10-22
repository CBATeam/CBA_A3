/* ----------------------------------------------------------------------------
Function: CBA_fnc_vect2Polar

Description:
    Converts a 3d vector to polar
Parameters:
    _vx - vector direction in x
    _vy - vector direction in y
    _vz - vector direction in z

Returns:
    a vector in the form [magnitude, azimuth, elevation].

Examples:
    (begin example)
    [5, 5, 10] call CBA_fnc_vect2Polar
    (end)

Author:
    Vigilante, courtesy by -=ACE=- of Simcentric
---------------------------------------------------------------------------- */
scriptName "fnc_vect2Polar.sqf";

#include "script_component.hpp"
SCRIPT(vect2Polar);


params ["_vx", "_vy", "_vz"];

private _mag = vectorMagnitude _this;
private _elev = if (_mag > 0) then {asin (_vz / _mag)} else {0};
private _dir = _this call CBA_fnc_vectDir;

[_mag, _dir, _elev];
