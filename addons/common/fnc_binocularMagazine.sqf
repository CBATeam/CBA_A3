#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_binocularMagazine

Description:
    Returns the magazine of the units rangefinder.

Parameters:
    _unit - A unit <OBJECT>

Returns:
    Magazine of the units binocular <STRING>

Examples:
    (begin example)
        player call CBA_fnc_binocularMagazine
    (end)

Author:
    commy2, johnb43
---------------------------------------------------------------------------- */
SCRIPT(binocularMagazine);

params [["_unit", objNull, [objNull]]];

binocularMagazine _unit
