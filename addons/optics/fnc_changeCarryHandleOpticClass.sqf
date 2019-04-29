#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: cba_optics_fnc_changeCarryHandleOpticClass

Description:
    Switch scripted optic class to class with integrated carry handle optic.

Parameters:
    _unit - The avatar <OBJECT>

Returns:
    Nothing.

Examples:
    (begin example)
        player call cba_optics_fnc_changeCarryHandleOpticClass;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

params ["_unit"];
if (!local _unit) exitWith {};

private _gun = primaryWeapon _unit;
private _gunOptic = primaryWeaponItems _unit select 2;
private _launcher = secondaryWeapon _unit;
private _launcherOptic = secondaryWeaponItems _unit select 2;
private _pistol = handgunWeapon _unit;
private _pistolOptic = handgunItems _unit select 2;

private _config = configFile >> "CfgWeapons";
private _gunCarryHandleType = getText (_config >> _gun >> "CBA_CarryHandleType");
private _launcherCarryHandleType = getText (_config >> _launcher >> "CBA_CarryHandleType");
private _pistolCarryHandleType = getText (_config >> _pistol >> "CBA_CarryHandleType");

// primary weapon
if (_gunCarryHandleType != "" && {!GVAR(inArsenal)}) then {
    _gunOptic = GVAR(NonCarryHandleOptics) getVariable [_gunOptic, _gunOptic];
    _gunOptic = GVAR(CarryHandleOptics) getVariable format ["%1@%2", _gunOptic, _gunCarryHandleType];
} else {
    _gunOptic = GVAR(NonCarryHandleOptics) getVariable _gunOptic;
};

if (!isNil "_gunOptic") then {
    INFO_1("Switched rifle optic to %1.",_gunOptic);
    _unit addPrimaryWeaponItem _gunOptic;
};

// secondary weapon
if (_launcherCarryHandleType != "" && {!GVAR(inArsenal)}) then {
    _launcherOptic = GVAR(NonCarryHandleOptics) getVariable [_launcherOptic, _launcherOptic];
    _launcherOptic = GVAR(CarryHandleOptics) getVariable format ["%1@%2", _launcherOptic, _launcherCarryHandleType];
} else {
    _launcherOptic = GVAR(NonCarryHandleOptics) getVariable _launcherOptic;
};

if (!isNil "_launcherOptic") then {
    INFO_1("Switched launcher optic to %1.",_launcherOptic);
    _unit addSecondaryWeaponItem _launcherOptic;
};

// handgun
if (_pistolCarryHandleType != "" && {!GVAR(inArsenal)}) then {
    _pistolOptic = GVAR(NonCarryHandleOptics) getVariable [_pistolOptic, _pistolOptic];
    _pistolOptic = GVAR(CarryHandleOptics) getVariable format ["%1@%2", _pistolOptic, _pistolCarryHandleType];
} else {
    _pistolOptic = GVAR(NonCarryHandleOptics) getVariable _pistolOptic;
};

if (!isNil "_pistolOptic") then {
    INFO_1("Switched pistol optic to %1.",_pistolOptic);
    _unit addHandgunItem _pistolOptic;
};
