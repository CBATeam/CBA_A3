#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_vectSubtract

Description:
 Returns the difference of two vectors.  Vectors can be 2D or 3D.

Parameters:
 _u the first vector.
 _v the second vector.

Returns:
 the sum of the two vectors (u - v).

Examples:
    (begin example)

    (end)

Author:
    Vigilante, courtesy by -=ACE=- of Simcentric
---------------------------------------------------------------------------- */
scriptName "fnc_vectSubtract.sqf";

SCRIPT(vectSubtract);


params ["_u", "_v"];

private _i = (_u select 0) - (_v select 0);
private _k = (_u select 1) - (_v select 1);
private _j = (_u select 2) - (_v select 2);

[_i, _k, _j];
