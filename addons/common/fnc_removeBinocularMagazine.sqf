#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeBinocularMagazine

Description:
    Removes the magazine of the units rangefinder.

Parameters:
    _unit - A unit <OBJECT>

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

private _binocular = binocular _unit;
private _selectBinocular = currentWeapon _unit isEqualTo _binocular;

_unit addWeapon _binocular;

if (_selectBinocular) then {
    _unit selectWeapon _binocular;
};
