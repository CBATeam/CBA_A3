#include "script_component.hpp"

ADDON = false;

if (configProperties [configFile >> "CBA_DisposableLaunchers"] isEqualTo []) exitWith {};

#include "XEH_PREP.sqf"

private _fnc_update = {
    params ["_unit"];
    if (!local _unit) exitWith {};
    (GVAR(NormalLaunchers) getVariable secondaryWeapon _unit) params ["_launcher", "_magazine"];

    if (!isNil "_launcher") then {
        private _launcherItems = secondaryWeaponItems _unit;

        [_unit, _launcher] call CBA_fnc_addWeaponWithoutMagazines;

        {
            _unit addSecondaryWeaponItem _x;
        } forEach _launcherItems;

        _unit addWeaponItem [_launcher, _magazine];
    };
};

["loadout", _fnc_update] call CBA_fnc_addPlayerEventHandler;
["CAManBase", "InitPost", _fnc_update] call CBA_fnc_addClassEventHandler;
["CAManBase", "Take", _fnc_update] call CBA_fnc_addClassEventHandler;

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

["All", "InitPost", FUNC(replaceMagazineCargo)] call CBA_fnc_addClassEventHandler;

ADDON = true;
