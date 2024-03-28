#include "script_component.hpp"

ADDON = false;

#include "initSettings.inc.sqf"

if (configProperties [configFile >> "CBA_DisposableLaunchers"] isEqualTo []) exitWith {};

#include "XEH_PREP.hpp"

["loadout", {
    params ["_unit"];
    _unit call FUNC(changeDisposableLauncherClass);
}] call CBA_fnc_addPlayerEventHandler;

["CAManBase", "InitPost", {
    params ["_unit"];
    _unit call FUNC(changeDisposableLauncherClass);
}] call CBA_fnc_addClassEventHandler;

["CAManBase", "Take", {
    params ["_unit"];
    _unit call FUNC(changeDisposableLauncherClass);
}] call CBA_fnc_addClassEventHandler;

GVAR(NormalLaunchers) = [] call CBA_fnc_createNamespace;
GVAR(LoadedLaunchers) = [] call CBA_fnc_createNamespace;
GVAR(UsedLaunchers) = [] call CBA_fnc_createNamespace;
GVAR(magazines) = [];
GVAR(BackpackLaunchers) = createHashMap;
GVAR(MagazineLaunchers) = [] call CBA_fnc_createNamespace;

private _cfgWeapons = configFile >> "CfgWeapons";
private _cfgMagazines = configFile >> "CfgMagazines";

{
    private _launcher = configName _x;
    private _magazine = configName (_cfgMagazines >> (getArray (_cfgWeapons >> _launcher >> "magazines") select 0));
    getArray _x params ["_loadedLauncher", "_usedLauncher"];
    private _fitsInBackpacks = TYPE_BACKPACK in getArray (configFile >> "CfgWeapons" >> _loadedLauncher >> "WeaponSlotsInfo" >> "allowedSlots");

    GVAR(LoadedLaunchers) setVariable [_launcher, _loadedLauncher];
    GVAR(UsedLaunchers) setVariable [_launcher, _usedLauncher];

    if (isNil {GVAR(NormalLaunchers) getVariable _loadedLauncher}) then {
        GVAR(NormalLaunchers) setVariable [_loadedLauncher, [_launcher, _magazine]];
    };

    if (GVAR(magazines) pushBackUnique _magazine != -1) then {
        GVAR(MagazineLaunchers) setVariable [_magazine, _loadedLauncher];
    };

    if (_fitsInBackpacks) then {
        GVAR(BackpackLaunchers) set [_loadedLauncher, true];
    };

    // check if mass entries add up
    private _massLauncher = getNumber (_cfgWeapons >> _launcher >> "WeaponSlotsInfo" >> "mass");
    private _massMagazine = getNumber (_cfgMagazines >> _magazine >> "mass");
    private _massLoadedLauncher = getNumber (_cfgWeapons >> _loadedLauncher >> "WeaponSlotsInfo" >> "mass");
    private _massUsedLauncher = getNumber (_cfgWeapons >> _usedLauncher >> "WeaponSlotsInfo" >> "mass");

    if (_massLauncher != _massUsedLauncher) then {
        WARNING_4("Mass of launcher %1 (%2) is different from mass of used launcher %3 (%4).",_launcher,_massLauncher,_usedLauncher,_massUsedLauncher);
    };

    if (_massLauncher + _massMagazine != _massLoadedLauncher) then {
        WARNING_7("Sum of mass of launcher %1 and mass of magazine %2 (%3+%4=%5) is different from mass of loaded launcher %6 (%7).",_launcher,_magazine,_massLauncher,_massMagazine,_massLauncher + _massMagazine,_loadedLauncher,_massLoadedLauncher);
    };
} forEach configProperties [configFile >> "CBA_DisposableLaunchers", "isArray _x"];

["CBA_settingsInitialized", {
    ["All", "InitPost", {call FUNC(replaceMagazineCargo)}, nil, nil, true] call CBA_fnc_addClassEventHandler;
}] call CBA_fnc_addEventHandler;

ADDON = true;
