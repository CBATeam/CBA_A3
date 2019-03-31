#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_currentOptic

Description:
    Creates a new setting for that session.

Parameters:
    _unit - A unit with weapon <OBJECT>

Returns:
    _optic - The optic of the current weapon. <STRING>
        If the weapon has no optic, it reports the current weapon instead.
        This never reports a muzzle, but the actual weapon.
        Will report the binocular if selected.
        If no weapon is equipped or selected, it reports the empty string "".

Examples:
    (begin example)
        player call CBA_fnc_currentOptic
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

params ["_unit"];

private _weapon = currentWeapon _unit;

private _gun = primaryWeapon _unit;
if (_weapon isEqualTo _gun) exitWith {
    private _optic = primaryWeaponItems _unit select 2;

    if (_optic isEqualTo "") then {
        _optic = _gun;
    };

    _optic
};

private _launcher = secondaryWeapon _unit;
if (_weapon isEqualTo _launcher) exitWith {
    private _optic = secondaryWeaponItems _unit select 2;

    if (_optic isEqualTo "") then {
        _optic = _launcher;
    };

    _optic
};

private _pistol = handgunWeapon _unit;
if (_weapon isEqualTo _pistol) exitWith {
    private _optic = handgunItems _unit select 2;

    if (_optic isEqualTo "") then {
        _optic = _pistol;
    };

    _optic
};

private _binocular = binocular _unit;
if (_weapon isEqualTo _binocular) exitWith {
    _binocular
};

""
