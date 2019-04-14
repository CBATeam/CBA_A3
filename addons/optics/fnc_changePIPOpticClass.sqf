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

if (GVAR(usePipOptics) && {!GVAR(inArsenal)}) then {
    // Gun, switch to pip weapon.
    private _gun = primaryWeapon _unit;
    private _gunItems = primaryWeaponItems _unit;
    private _gunMagazine = primaryWeaponMagazine _unit;

    private _pipGun = GVAR(PIPOptics) getVariable _gun;

    if (!isNil "_pipGun") then {
        private _muzzle = currentMuzzle _unit;
        _unit addWeapon _pipGun;
        if (_muzzle isEqualType "") then {_unit selectWeapon _muzzle};

        {
            _unit addPrimaryWeaponItem _x;
        } forEach _gunItems;

        {
            _unit addWeaponItem [_pipGun, _x];
        } forEach _gunMagazine;

        INFO_2("Switched %1 to %2.",_gun,_pipGun);
    };

    // Launcher, switch to pip weapon.
    private _launcher = secondaryWeapon _unit;
    private _launcherItems = secondaryWeaponItems _unit;
    private _launcherMagazine = secondaryWeaponMagazine _unit;

    private _pipLauncher = GVAR(PIPOptics) getVariable _launcher;

    if (!isNil "_pipLauncher") then {
        private _muzzle = currentMuzzle _unit;
        _unit addWeapon _pipLauncher;
        if (_muzzle isEqualType "") then {_unit selectWeapon _muzzle};

        {
            _unit addSecondaryWeaponItem _x;
        } forEach _launcherItems;

        {
            _unit addWeaponItem [_pipLauncher, _x];
        } forEach _launcherMagazine;

        INFO_2("Switched %1 to %2.",_launcher,_pipLauncher);
    };

    // Pistol, switch to pip weapon.
    private _pistol = handgunWeapon _unit;
    private _pistolItems = handgunItems _unit;
    private _pistolMagazine = handgunMagazine _unit;

    private _pipPistol = GVAR(PIPOptics) getVariable _pistol;

    if (!isNil "_pipPistol") then {
        private _muzzle = currentMuzzle _unit;
        _unit addWeapon _pipPistol;
        if (_muzzle isEqualType "") then {_unit selectWeapon _muzzle};

        {
            _unit addHandgunItem _x;
        } forEach _pistolItems;

        {
            _unit addWeaponItem [_pipPistol, _x];
        } forEach _pistolMagazine;

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
    private _gunItems = primaryWeaponItems _unit;
    private _gunMagazine = primaryWeaponMagazine _unit;

    private _normalGun = GVAR(NonPIPOptics) getVariable _gun;

    if (!isNil "_normalGun") then {
        private _muzzle = currentMuzzle _unit;
        _unit addWeapon _normalGun;
        if (_muzzle isEqualType "") then {_unit selectWeapon _muzzle};

        {
            _unit addPrimaryWeaponItem _x;
        } forEach _gunItems;

        {
            _unit addWeaponItem [_normalGun, _x];
        } forEach _gunMagazine;

        INFO_2("Switched %1 to %2.",_gun,_normalGun);
    };

    // Launcher, switch to normal weapon.
    private _launcher = secondaryWeapon _unit;
    private _launcherItems = secondaryWeaponItems _unit;
    private _launcherMagazine = secondaryWeaponMagazine _unit;

    private _normalLauncher = GVAR(NonPIPOptics) getVariable _launcher;

    if (!isNil "_normalLauncher") then {
        private _muzzle = currentMuzzle _unit;
        _unit addWeapon _normalLauncher;
        if (_muzzle isEqualType "") then {_unit selectWeapon _muzzle};

        {
            _unit addSecondaryWeaponItem _x;
        } forEach _launcherItems;

        {
            _unit addWeaponItem [_normalLauncher, _x];
        } forEach _launcherMagazine;

        INFO_2("Switched %1 to %2.",_launcher,_normalLauncher);
    };

    // Pistol, switch to normal weapon.
    private _pistol = handgunWeapon _unit;
    private _pistolItems = handgunItems _unit;
    private _pistolMagazine = handgunMagazine _unit;

    private _normalPistol = GVAR(NonPIPOptics) getVariable _pistol;

    if (!isNil "_normalPistol") then {
        private _muzzle = currentMuzzle _unit;
        _unit addWeapon _normalPistol;
        if (_muzzle isEqualType "") then {_unit selectWeapon _muzzle};

        {
            _unit addHandgunItem _x;
        } forEach _pistolItems;

        {
            _unit addWeaponItem [_normalPistol, _x];
        } forEach _pistolMagazine;

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
