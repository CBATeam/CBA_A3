#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_addWeaponWithoutMagazines

Description:
    Adds weapon to unit without taking a magazine.

    Does not work on vehicles.
    Attempts to keep magazine ids for unrelated magazines.

Parameters:
    _unit   - Unit to add the weapon to <OBEJCT>
    _weapon - Weapon to add <STRING>

Returns:
    Nothing.

Examples:
    (begin example)
        [player, "arifle_mx_F"] CBA_fnc_addWeaponWithoutMagazines;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

params ["_unit", "_weapon"];

// config case
private _compatibleMagazines = [_weapon, true] call CBA_fnc_compatibleMagazines;

private _uniform = uniformContainer _unit;
private _uniformMagazines = magazinesAmmoCargo _uniform select {
    (_x select 0) in _compatibleMagazines // also config case
};

private _vest = vestContainer _unit;
private _vestMagazines = magazinesAmmoCargo _vest select {
    (_x select 0) in _compatibleMagazines
};

private _backpack = backpackContainer _unit;
private _backpackMagazines = magazinesAmmoCargo _backpack select {
    (_x select 0) in _compatibleMagazines
};

{
    _unit removeMagazines _x;
} forEach _compatibleMagazines;

_unit addWeapon _weapon;

{
    _x params ["_magazine", "_ammo"];
    _uniform addMagazineAmmoCargo [_magazine, 1, _ammo];
} forEach _uniformMagazines;

{
    _x params ["_magazine", "_ammo"];
    _vest addMagazineAmmoCargo [_magazine, 1, _ammo];
} forEach _vestMagazines;

{
    _x params ["_magazine", "_ammo"];
    _backpack addMagazineAmmoCargo [_magazine, 1, _ammo];
} forEach _backpackMagazines;
