#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_addBinocularMagazine

Description:
    Adds a magazine to the units rangefinder.

Parameters:
    _unit     - A unit <OBJECT>
    _magazine - The magazine to add <STRING>
    _ammo     - Ammo count of the magazine (optional, default: full magazine) <NUMBER>

Returns:
    None

Examples:
    (begin example)
        player addWeapon "Laserdesignator";
        [player, "Laserbatteries"] call CBA_fnc_addBinocularMagazine;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
SCRIPT(addBinocularMagazine);

params [["_unit", objNull, [objNull]], ["_magazine", "", [""]], ["_ammo", nil, [0]]];

if (!local _unit) exitWith {};

_unit addWeaponItem [binocular _unit, [_magazine, _ammo], true];
