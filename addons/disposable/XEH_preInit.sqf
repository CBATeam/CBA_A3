#include "script_component.hpp"

ADDON = false;

#include "initSettings.sqf"

if (configProperties [configFile >> "CBA_DisposableLaunchers"] isEqualTo []) exitWith {};

#include "XEH_PREP.sqf"

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
GVAR(MagazineLaunchers) = [] call CBA_fnc_createNamespace;

private _cfgWeapons = configFile >> "CfgWeapons";
private _cfgMagazines = configFile >> "CfgMagazines";

{
    private _launcher = configName _x;
    private _magazine = configName (_cfgMagazines >> (getArray (_cfgWeapons >> _launcher >> "magazines") select 0));
    getArray _x params ["_loadedLauncher", "_usedLauncher"];

    GVAR(LoadedLaunchers) setVariable [_launcher, _loadedLauncher];
    GVAR(UsedLaunchers) setVariable [_launcher, _usedLauncher];

    if (isNil {GVAR(NormalLaunchers) getVariable _loadedLauncher}) then {
        GVAR(NormalLaunchers) setVariable [_loadedLauncher, [_launcher, _magazine]];
    };

    if (GVAR(magazines) pushBackUnique _magazine != -1) then {
        GVAR(MagazineLaunchers) setVariable [_magazine, _loadedLauncher];
    };
} forEach configProperties [configFile >> "CBA_DisposableLaunchers", "isArray _x"];

["CBA_settingsInitialized", {
    ["All", "InitPost", FUNC(replaceMagazineCargo), nil, nil, true] call CBA_fnc_addClassEventHandler;
}] call CBA_fnc_addEventHandler;

ADDON = true;
