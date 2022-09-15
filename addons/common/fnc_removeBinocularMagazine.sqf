#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeBinocularMagazine

Description:
    Removes the magazine of the units rangefinder.

Parameters:
    _unit - A unit (must be local) <OBJECT>

Returns:
    None

Examples:
    (begin example)
        player call CBA_fnc_removeBinocularMagazine
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
SCRIPT(removeBinocularMagazine);

params [["_unit", objNull, [objNull]]];

if (!local _unit) exitWith {};

_unit removeBinocularItem (binocularMagazine _unit);
