#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: cba_disposable_fnc_replaceMagazineCargo

Description:
    Replaces disposable launcher magazines with loaded disposable launchers.

Parameters:
    _box - Any object with cargo <OBJECT>

Returns:
    Nothing.

Examples:
    (begin example)
        _box call cba_disposable_fnc_replaceMagazineCargo
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

if (!GVAR(replaceDisposableLauncher)) exitWith {};

params ["_box"];
if (!local _box) exitWith {};
if (missionNamespace getVariable [QGVAR(disableMagazineReplacement), false]) exitWith {};

private _uniformContainer = uniformContainer _box;
if (!isNull _uniformContainer) then {
    _uniformContainer call FUNC(replaceMagazineCargo);
};

private _vestContainer = vestContainer _box;
if (!isNull _vestContainer) then {
    _vestContainer call FUNC(replaceMagazineCargo);
};

private _backpackContainer = backpackContainer _box;
if (!isNull _backpackContainer) then {
    _backpackContainer call FUNC(replaceMagazineCargo);
};

{
    _x call FUNC(replaceMagazineCargo);
} forEach everyBackpack _box;

if (magazineCargo _box arrayIntersect GVAR(magazines) isEqualTo []) exitWith {};

private _magazines = magazinesAmmoCargo _box;
clearMagazineCargoGlobal _box;

private _isBackpack = getNumber (configFile >> "CfgVehicles" >> typeOf _box >> "isBackpack") != -1;

{
    _x params ["_magazine", "_ammo"];

    if (_magazine in GVAR(magazines)) then {
        if !(_isBackpack) then {
            _box addWeaponCargoGlobal [GVAR(MagazineLaunchers) getVariable _magazine, 1];
        };
    } else {
        _box addMagazineAmmoCargo [_magazine, 1, _ammo];
    };
} forEach _magazines;
