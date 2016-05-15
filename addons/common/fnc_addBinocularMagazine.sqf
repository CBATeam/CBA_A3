/* ----------------------------------------------------------------------------
Function: CBA_fnc_addBinocularMagazine

Description:
    Adds a magazine to the units rangefinder.

    Note that this breaks the unique magazine ids due to the usage of setUnitLoadout.

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
#include "script_component.hpp"
SCRIPT(addBinocularMagazine);

params [["_unit", objNull, [objNull]], ["_magazine", "", [""]], ["_ammo", nil, [0]]];

if (!local _unit) exitWith {};

if (isNil "_ammo") then {
    _ammo = getNumber (configFile >> "CfgMagazines" >> _magazine >> "count");
};

private _loadout = getUnitLoadout _unit;
(_loadout select 8) set [4, [_magazine, _ammo]];

_unit setUnitLoadout _loadout;
