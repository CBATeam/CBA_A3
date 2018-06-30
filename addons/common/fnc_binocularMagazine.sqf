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
    commy2
---------------------------------------------------------------------------- */
SCRIPT(binocularMagazine);

params [["_unit", objNull, [objNull]]];

private _binocular = binocular _unit;
private _magazine = "";

{
    if ((_x select 0) isEqualTo _binocular) exitWith {
        // note: if there is no magazine, _x(4,0) will be nil
        _magazine = (_x select 4) param [0, ""];
    };
} forEach weaponsitems _unit;

_magazine
