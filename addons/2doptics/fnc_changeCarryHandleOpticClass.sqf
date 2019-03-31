#include "script_component.hpp"

// force unscheduled environment
if (canSuspend) exitWith {
    isNil BWA3_fnc_changeCarryHandleOpticClass;
};

params ["_unit"];

private _forceBase = BWA3_inArsenal;

private _gun = primaryWeapon _unit;
private _gunOptic = primaryWeaponItems _unit select 2;
private _launcher = secondaryWeapon _unit;
private _launcherOptic = secondaryWeaponItems _unit select 2;
private _pistol = handgunWeapon _unit;
private _pistolOptic = handgunItems _unit select 2;

private _config = configFile >> "CfgWeapons";

// primary weapon
if (HAS_CARRY_HANDLE(_gun) && {!_forceBase}) then {
    _gunOptic = BWA3_CarryHandleOptics getVariable _gunOptic;
} else {
    _gunOptic = BWA3_NonCarryHandleOptics getVariable _gunOptic;
};

if (!isNil "_gunOptic") then {
    BWA3_LOGINFO_1("Switched rifle optic to %1.",_gunOptic);
    _unit addPrimaryWeaponItem _gunOptic;
};

// secondary weapon
if (HAS_CARRY_HANDLE(_launcher) && {!_forceBase}) then {
    _launcherOptic = BWA3_CarryHandleOptics getVariable _launcherOptic;
} else {
    _launcherOptic = BWA3_NonCarryHandleOptics getVariable _launcherOptic;
};

if (!isNil "_launcherOptic") then {
    BWA3_LOGINFO_1("Switched launcher optic to %1.",_launcherOptic);
    _unit addSecondaryWeaponItem _launcherOptic;
};

// handgun
if (HAS_CARRY_HANDLE(_pistol) && {!_forceBase}) then {
    _pistolOptic = BWA3_CarryHandleOptics getVariable _pistolOptic;
} else {
    _pistolOptic = BWA3_NonCarryHandleOptics getVariable _pistolOptic;
};

if (!isNil "_pistolOptic") then {
    BWA3_LOGINFO_1("Switched pistol optic to %1.",_pistolOptic);
    _unit addHandgunItem _pistolOptic;
};
