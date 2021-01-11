#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: cba_optics_fnc_changePIPOpticClass

Description:
    Switch scripted optic class to PIP class.

Parameters:
    _unit - The avatar <OBJECT>

Returns:
    Nothing.

Examples:
    (begin example)
        player call cba_optics_fnc_changePIPOpticClass;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

params ["_unit"];
if (!local _unit) exitWith {};

if (GVAR(usePipOptics) && {!GVAR(inArsenal)}) then {
    // Gun, switch to pip weapon.
    private _gun = primaryWeapon _unit;
    private _pipGun = GVAR(PIPOptics) getVariable _gun;

    if (!isNil "_pipGun") then {
        private _gunItems = primaryWeaponItems _unit;
        private _gunMagazines = WEAPON_MAGAZINES(_unit,_gun);

        private _muzzle = currentMuzzle _unit;
        private _mode = currentWeaponMode _unit;

        if (_muzzle == currentWeapon _unit) then {
            _muzzle = _pipGun;
        };

        [_unit, _pipGun] call CBA_fnc_addWeaponWithoutItems;
        [_unit, _muzzle, _mode] call CBA_fnc_selectWeapon;

        {
            _unit addPrimaryWeaponItem _x;
        } forEach _gunItems;

        {
            _unit addWeaponItem [_pipGun, _x];
        } forEach _gunMagazines;

        INFO_2("Switched %1 to %2.",_gun,_pipGun);
    };

    // Launcher, switch to pip weapon.
    private _launcher = secondaryWeapon _unit;
    private _pipLauncher = GVAR(PIPOptics) getVariable _launcher;

    if (!isNil "_pipLauncher") then {
        private _launcherItems = secondaryWeaponItems _unit;
        private _launcherMagazines = WEAPON_MAGAZINES(_unit,_launcher);

        private _muzzle = currentMuzzle _unit;
        private _mode = currentWeaponMode _unit;

        if (_muzzle == currentWeapon _unit) then {
            _muzzle = _pipLauncher;
        };

        [_unit, _pipLauncher] call CBA_fnc_addWeaponWithoutItems;
        [_unit, _muzzle, _mode] call CBA_fnc_selectWeapon;

        {
            _unit addSecondaryWeaponItem _x;
        } forEach _launcherItems;

        {
            _unit addWeaponItem [_pipLauncher, _x];
        } forEach _launcherMagazines;

        INFO_2("Switched %1 to %2.",_launcher,_pipLauncher);
    };

    // Pistol, switch to pip weapon.
    private _pistol = handgunWeapon _unit;
    private _pipPistol = GVAR(PIPOptics) getVariable _pistol;

    if (!isNil "_pipPistol") then {
        private _pistolItems = handgunItems _unit;
        private _pistolMagazines = WEAPON_MAGAZINES(_unit,_pistol);

        private _muzzle = currentMuzzle _unit;
        private _mode = currentWeaponMode _unit;

        if (_muzzle == currentWeapon _unit) then {
            _muzzle = _pipPistol;
        };

        [_unit, _pipPistol] call CBA_fnc_addWeaponWithoutItems;
        [_unit, _muzzle, _mode] call CBA_fnc_selectWeapon;

        {
            _unit addHandgunItem _x;
        } forEach _pistolItems;

        {
            _unit addWeaponItem [_pipPistol, _x];
        } forEach _pistolMagazines;

        INFO_2("Switched %1 to %2.",_pistol,_pipPistol);
    };

    // Switch to pip optic attchments.
    {
        _x params ["_weapon", "", "", "_optic"]; // ["_weapon", "_muzzle", "_pointer", "_optic", "_magazine", "_bipod"]

        private _pipOptic = GVAR(PIPOptics) getVariable _optic;

        if (!isNil "_pipOptic") then {
            _unit addWeaponItem [_weapon, _pipOptic];
            INFO_2("Switched %1 to %2.",_optic,_pipOptic);
        };
    } forEach weaponsItems _unit;
} else {
    // Gun, switch to normal weapon.
    private _gun = primaryWeapon _unit;
    private _normalGun = GVAR(NonPIPOptics) getVariable _gun;

    if (!isNil "_normalGun") then {
        private _gunItems = primaryWeaponItems _unit;
        private _gunMagazines = WEAPON_MAGAZINES(_unit,_gun);

        private _muzzle = currentMuzzle _unit;
        private _mode = currentWeaponMode _unit;

        if (_muzzle == currentWeapon _unit) then {
            _muzzle = _normalGun;
        };

        [_unit, _normalGun] call CBA_fnc_addWeaponWithoutItems;
        [_unit, _muzzle, _mode] call CBA_fnc_selectWeapon;

        {
            _unit addPrimaryWeaponItem _x;
        } forEach _gunItems;

        {
            _unit addWeaponItem [_normalGun, _x];
        } forEach _gunMagazines;

        INFO_2("Switched %1 to %2.",_gun,_normalGun);
    };

    // Launcher, switch to normal weapon.
    private _launcher = secondaryWeapon _unit;
    private _normalLauncher = GVAR(NonPIPOptics) getVariable _launcher;

    if (!isNil "_normalLauncher") then {
        private _launcherItems = secondaryWeaponItems _unit;
        private _launcherMagazines = WEAPON_MAGAZINES(_unit,_launcher);

        private _muzzle = currentMuzzle _unit;
        private _mode = currentWeaponMode _unit;

        if (_muzzle == currentWeapon _unit) then {
            _muzzle = _normalLauncher;
        };

        [_unit, _normalLauncher] call CBA_fnc_addWeaponWithoutItems;
        [_unit, _muzzle, _mode] call CBA_fnc_selectWeapon;

        {
            _unit addSecondaryWeaponItem _x;
        } forEach _launcherItems;

        {
            _unit addWeaponItem [_normalLauncher, _x];
        } forEach _launcherMagazines;

        INFO_2("Switched %1 to %2.",_launcher,_normalLauncher);
    };

    // Pistol, switch to normal weapon.
    private _pistol = handgunWeapon _unit;
    private _normalPistol = GVAR(NonPIPOptics) getVariable _pistol;

    if (!isNil "_normalPistol") then {
        private _pistolItems = handgunItems _unit;
        private _pistolMagazines = WEAPON_MAGAZINES(_unit,_pistol);

        private _muzzle = currentMuzzle _unit;
        private _mode = currentWeaponMode _unit;

        if (_muzzle == currentWeapon _unit) then {
            _muzzle = _normalPistol;
        };

        [_unit, _normalPistol] call CBA_fnc_addWeaponWithoutItems;
        [_unit, _muzzle, _mode] call CBA_fnc_selectWeapon;

        {
            _unit addHandgunItem _x;
        } forEach _pistolItems;

        {
            _unit addWeaponItem [_normalPistol, _x];
        } forEach _pistolMagazines;

        INFO_2("Switched %1 to %2.",_pistol,_normalPistol);
    };

    // Switch to normal optic attchments.
    {
        _x params ["_weapon", "", "", "_optic"];

        private _normalOptic = GVAR(NonPIPOptics) getVariable _optic;

        if (!isNil "_normalOptic") then {
            _unit addWeaponItem [_weapon, _normalOptic];
            INFO_2("Switched %1 to %2.",_optic,_normalOptic);
        };
    } forEach weaponsItems _unit;
};
