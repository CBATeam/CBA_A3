#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeBinocularMagazine

Description:
    Removes the magazine of the units rangefinder.

    Has to be executed on the machine where the unit is local.

Parameters:
    _unit - A unit <OBJECT>

Returns:
    None

Examples:
    (begin example)
        player call CBA_fnc_removeBinocularMagazine
    (end)

Author:
    commy2, johnb43
---------------------------------------------------------------------------- */
SCRIPT(removeBinocularMagazine);

params [["_unit", objNull, [objNull]]];

if (!local _unit) exitWith {};

_unit removeBinocularItem (binocularMagazine _unit);
