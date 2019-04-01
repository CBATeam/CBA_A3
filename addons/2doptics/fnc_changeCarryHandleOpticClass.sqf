#include "script_component.hpp"

// force unscheduled environment
if (canSuspend) exitWith {
    isNil FUNC(changeCarryHandleOpticClass);
};

params ["_unit"];

private _gun = primaryWeapon _unit;
private _gunOptic = primaryWeaponItems _unit select 2;
private _launcher = secondaryWeapon _unit;
private _launcherOptic = secondaryWeaponItems _unit select 2;
private _pistol = handgunWeapon _unit;
private _pistolOptic = handgunItems _unit select 2;

private _config = configFile >> "CfgWeapons";

// primary weapon
if (HAS_CARRY_HANDLE(_gun) && {!GVAR(inArsenal)}) then {
    _gunOptic = BWA3_CarryHandleOptics getVariable _gunOptic;
} else {
    _gunOptic = BWA3_NonCarryHandleOptics getVariable _gunOptic;
};

if (!isNil "_gunOptic") then {
    INFO_1("Switched rifle optic to %1.",_gunOptic);
    _unit addPrimaryWeaponItem _gunOptic;
};

// secondary weapon
if (HAS_CARRY_HANDLE(_launcher) && {!GVAR(inArsenal)}) then {
    _launcherOptic = BWA3_CarryHandleOptics getVariable _launcherOptic;
} else {
    _launcherOptic = BWA3_NonCarryHandleOptics getVariable _launcherOptic;
};

if (!isNil "_launcherOptic") then {
    INFO_1("Switched launcher optic to %1.",_launcherOptic);
    _unit addSecondaryWeaponItem _launcherOptic;
};

// handgun
if (HAS_CARRY_HANDLE(_pistol) && {!GVAR(inArsenal)}) then {
    _pistolOptic = BWA3_CarryHandleOptics getVariable _pistolOptic;
} else {
    _pistolOptic = BWA3_NonCarryHandleOptics getVariable _pistolOptic;
};

if (!isNil "_pistolOptic") then {
    INFO_1("Switched pistol optic to %1.",_pistolOptic);
    _unit addHandgunItem _pistolOptic;
};
