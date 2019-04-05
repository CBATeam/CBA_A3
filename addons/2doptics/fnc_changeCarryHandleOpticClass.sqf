#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: cba_2doptics_fnc_changeCarryHandleOpticClass

Description:
    Switch scripted optic class to class with integrated carry handle optic.

Parameters:
    _unit - The avatar <OBJECT>

Returns:
    Nothing.

Examples:
    (begin example)
        player call cba_2doptics_fnc_changeCarryHandleOpticClass;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

params ["_unit"];

private _gun = primaryWeapon _unit;
private _gunOptic = primaryWeaponItems _unit select 2;
private _launcher = secondaryWeapon _unit;
private _launcherOptic = secondaryWeaponItems _unit select 2;
private _pistol = handgunWeapon _unit;
private _pistolOptic = handgunItems _unit select 2;

private _config = configFile >> "CfgWeapons";

// primary weapon
private _carryHandleType = getText (_config >> _gun >> "CBA_CarryHandleType");

if (_carryHandleType != "" && {!GVAR(inArsenal)}) then {
    _gunOptic = GVAR(NonCarryHandleOptics) getVariable [_gunOptic, _gunOptic];
    _gunOptic = GVAR(CarryHandleOptics) getVariable format ["%1@%2", _gunOptic, _carryHandleType];
} else {
    _gunOptic = GVAR(NonCarryHandleOptics) getVariable _gunOptic;
};

if (!isNil "_gunOptic") then {
    INFO_1("Switched rifle optic to %1.",_gunOptic);
    _unit addPrimaryWeaponItem _gunOptic;
};

// secondary weapon
_carryHandleType = getText (_config >> _launcher >> "CBA_CarryHandleType");

if (_carryHandleType != "" && {!GVAR(inArsenal)}) then {
    _launcherOptic = GVAR(NonCarryHandleOptics) getVariable [_launcherOptic, _launcherOptic];
    _launcherOptic = GVAR(CarryHandleOptics) getVariable format ["%1@%2", _launcherOptic, _carryHandleType];
} else {
    _launcherOptic = GVAR(NonCarryHandleOptics) getVariable _launcherOptic;
};

if (!isNil "_launcherOptic") then {
    INFO_1("Switched launcher optic to %1.",_launcherOptic);
    _unit addSecondaryWeaponItem _launcherOptic;
};

// handgun
_carryHandleType = getText (_config >> _pistol >> "CBA_CarryHandleType");

if (_carryHandleType != "" && {!GVAR(inArsenal)}) then {
    _pistolOptic = GVAR(NonCarryHandleOptics) getVariable [_pistolOptic, _pistolOptic];
    _pistolOptic = GVAR(CarryHandleOptics) getVariable format ["%1@%2", _pistolOptic, _carryHandleType];
} else {
    _pistolOptic = GVAR(NonCarryHandleOptics) getVariable _pistolOptic;
};

if (!isNil "_pistolOptic") then {
    INFO_1("Switched pistol optic to %1.",_pistolOptic);
    _unit addHandgunItem _pistolOptic;
};
