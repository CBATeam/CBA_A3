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

GVAR(NormalLaunchers) = createHashMap;
GVAR(LoadedLaunchers) = createHashMap;
GVAR(UsedLaunchers) = createHashMap;
GVAR(magazines) = [];
GVAR(BackpackLaunchers) = createHashMap;
GVAR(MagazineLaunchers) = createHashMap;

private _cfgWeapons = configFile >> "CfgWeapons";
private _cfgMagazines = configFile >> "CfgMagazines";

{
    // Get case-sensitive config names
    private _configLauncher = _cfgWeapons >> configName _x;
    private _launcher = configName _configLauncher;
    private _magazine = configName (_cfgMagazines >> (getArray (_configLauncher >> "magazines") select 0));
    getArray _x params ["_loadedLauncher", "_usedLauncher"];

    private _configLoadedLauncher = _cfgWeapons >> _loadedLauncher;
    _loadedLauncher = configName _configLoadedLauncher;
    private _fitsInBackpacks = TYPE_BACKPACK in getArray (_configLoadedLauncher >> "WeaponSlotsInfo" >> "allowedSlots");

    GVAR(LoadedLaunchers) set [_launcher, _loadedLauncher];
    GVAR(UsedLaunchers) set [_launcher, _usedLauncher];
    GVAR(NormalLaunchers) set [_loadedLauncher, [_launcher, _magazine], true]; // insert-only

    if (GVAR(magazines) pushBackUnique _magazine != -1) then {
        GVAR(MagazineLaunchers) set [_magazine, _loadedLauncher];
    };

    if (_fitsInBackpacks) then {
        GVAR(BackpackLaunchers) set [_loadedLauncher, true];
    };

    // check if mass entries add up
    private _massLauncher = getNumber (_configLauncher >> "WeaponSlotsInfo" >> "mass");
    private _massMagazine = getNumber (_cfgMagazines >> _magazine >> "mass");
    private _massLoadedLauncher = getNumber (_configLoadedLauncher >> "WeaponSlotsInfo" >> "mass");
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
