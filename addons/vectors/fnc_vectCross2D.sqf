/* ----------------------------------------------------------------------------
Function: CBA_fnc_vectCross2D

Description:
    Returns the cross product vector of two 2D vectors.

    The result is an integer value (positive or negative), representing the
    magnitude of the height component.

Parameters:
    _u the first vector.
    _v the second vector.

Returns:
    The cross product (scalar magnitude) of the two vectors.

Examples:
    (begin example)

    (end)

Author:
    Vigilante, courtesy by -=ACE=- of Simcentric
---------------------------------------------------------------------------- */
scriptName "fnc_vectCross2D.sqf";

#include "script_component.hpp"
SCRIPT(vectCross2D);

params ["_u","_v"];

((_u select 0) * (_v select 1)) - ((_u select 1) * (_v select 0));
