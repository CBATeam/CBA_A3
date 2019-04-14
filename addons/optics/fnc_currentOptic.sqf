#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: cba_optics_fnc_currentOptic

Description:
    Reports the currently selected optic classname of a person.

Parameters:
    _unit - A unit with weapon <OBJECT>

Returns:
    _optic - The optic of the current weapon. <STRING>
        If the weapon has no optic, it reports the current weapon instead.
        This never reports a muzzle, but the actual weapon.
        Will report the binocular if selected.
        If no weapon is equipped or selected, it reports the empty string "".
        Reports the empty string "" for vehicles and the null object.

Examples:
    (begin example)
        player call cba_optics_fnc_currentOptic
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

params ["_unit"];

private _weapon = currentWeapon _unit;

private _gun = primaryWeapon _unit;
if (_weapon isEqualTo _gun) exitWith {
    private _optic = [primaryWeaponItems _unit] param [0, [nil, nil, ""]] select 2;
    if (_optic != "") exitWith {_optic};
    _gun
};

private _launcher = secondaryWeapon _unit;
if (_weapon isEqualTo _launcher) exitWith {
    private _optic = [secondaryWeaponItems _unit] param [0, [nil, nil, ""]] select 2;
    if (_optic != "") exitWith {_optic};
    _launcher
};

private _pistol = handgunWeapon _unit;
if (_weapon isEqualTo _pistol) exitWith {
    private _optic = [handgunItems _unit] param [0, [nil, nil, ""]] select 2;
    if (_optic != "") exitWith {_optic};
    _pistol
};

private _binocular = binocular _unit;
if (_weapon isEqualTo _binocular) exitWith {
    _binocular
};

""
