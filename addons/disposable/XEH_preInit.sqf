#include "script_component.hpp"

ADDON = false;

#include "initSettings.inc.sqf"

if (configProperties [configFile >> "CBA_DisposableLaunchers"] isEqualTo []) exitWith {
    ADDON = true;
};

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
GVAR(allowedSlotsLaunchers) = createHashMap;
GVAR(MagazineLaunchers) = createHashMap;

private _cfgWeapons = configFile >> "CfgWeapons";
private _cfgMagazines = configFile >> "CfgMagazines";

{
    // Get case-sensitive config names
    private _configLauncher = _cfgWeapons >> configName _x;
    private _launcher = configName _configLauncher;
    private _magazine = (compatibleMagazines _launcher) select 0;

    if (_magazine == "") then {
        ERROR_1("Launcher %1 has an undefined magazine.",_launcher);

        continue;
    };

    (getArray _x) params [["_loadedLauncher", "", [""]], ["_usedLauncher", "", [""]]];

    if (_loadedLauncher == "") then {
        ERROR_1("Launcher %1 has an undefined loaded launcher.",_launcher);

        continue;
    };

    if (_usedLauncher == "") then {
        ERROR_1("Launcher %1 has an undefined used launcher.",_launcher);

        continue;
    };

    private _configLoadedLauncher = _cfgWeapons >> _loadedLauncher;
    _loadedLauncher = configName _configLoadedLauncher;

    GVAR(LoadedLaunchers) set [_launcher, _loadedLauncher];
    GVAR(UsedLaunchers) set [_launcher, _usedLauncher];
    GVAR(NormalLaunchers) set [_loadedLauncher, [_launcher, _magazine], true]; // insert-only

    if (GVAR(magazines) pushBackUnique _magazine != -1) then {
        GVAR(MagazineLaunchers) set [_magazine, _loadedLauncher];
    };

    GVAR(allowedSlotsLaunchers) set [_loadedLauncher, getArray (_configLoadedLauncher >> "WeaponSlotsInfo" >> "allowedSlots")];

    // check if mass entries add up
    private _massLauncher = getNumber (_configLauncher >> "WeaponSlotsInfo" >> "mass");
    private _massMagazine = getNumber (_cfgMagazines >> _magazine >> "mass");
    private _massLoadedLauncher = getNumber (_configLoadedLauncher >> "WeaponSlotsInfo" >> "mass");
    private _massUsedLauncher = getNumber (_cfgWeapons >> _usedLauncher >> "WeaponSlotsInfo" >> "mass");

    if (_massLauncher != _massUsedLauncher) then {
        WARNING_4("Mass of launcher %1 (%2) is different from mass of used launcher %3 (%4).",_launcher,_massLauncher,_usedLauncher,_massUsedLauncher);
    };

    if ((abs(_massLauncher + _massMagazine - _massLoadedLauncher)) > 0.011) then {
        WARNING_7("Sum of mass of launcher %1 and mass of magazine %2 (%3+%4=%5) is different from mass of loaded launcher %6 (%7).",_launcher,_magazine,_massLauncher,_massMagazine,_massLauncher + _massMagazine,_loadedLauncher,_massLoadedLauncher);
    };
} forEach configProperties [configFile >> "CBA_DisposableLaunchers", "isArray _x"];

["CBA_settingsInitialized", {
    ["All", "InitPost", {
        params ["_object"];

        [typeOf _object, _object] call FUNC(replaceMagazineCargo);
    }, nil, nil, true] call CBA_fnc_addClassEventHandler;
}] call CBA_fnc_addEventHandler;

ADDON = true;
