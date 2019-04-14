#include "script_component.hpp"

if (configProperties [configFile >> "CBA_DisposableLaunchers"] isEqualTo []) exitWith {};

ADDON = false;

private _fnc_update = {
    params ["_unit"];
    if (!local _unit) exitWith {};
    (BWA3_normalLaunchers getVariable secondaryWeapon _unit) params ["_launcher", "_magazine"];

    if (!isNil "_launcher") then {
        private _items = secondaryWeaponItems _unit;
        _unit addWeapon _launcher;
        _unit addWeaponItem [_launcher, _magazine];
        {_unit addSecondaryWeaponItem _x} forEach _items;
    };
};

["loadout", _fnc_update] call CBA_fnc_addPlayerEventHandler;
["CAManBase", "InitPost", _fnc_update] call CBA_fnc_addClassEventHandler;

private _fnc_arsenalOpened = {isNil {
    private _unit = call CBA_fnc_currentUnit;
    private _launcher = BWA3_loadedLaunchers getVariable secondaryWeapon _unit;

    if (!isNil "_launcher") then {
        private _items = secondaryWeaponItems _unit;
        _unit addWeapon _launcher;
        {_unit addSecondaryWeaponItem _x} forEach _items;
    };
}};

[missionNamespace, "arsenalOpened", _fnc_arsenalOpened] call BIS_fnc_addScriptedEventHandler;
["ace_arsenal_displayOpened", _fnc_arsenalOpened] call CBA_fnc_addEventHandler;

BWA3_normalLaunchers = [] call CBA_fnc_createNamespace;
BWA3_loadedLaunchers = [] call CBA_fnc_createNamespace;

{
    private _launcher = configName _x;
    private _magazine = getArray (configFile >> "CfgWeapons" >> _launcher >> "magazines") select 0;
    private _loadedLauncher = getText _x;

    BWA3_loadedLaunchers setVariable [_launcher, _loadedLauncher];

    if (isNil {BWA3_normalLaunchers getVariable _loadedLauncher}) then {
        BWA3_normalLaunchers setVariable [_loadedLauncher, [_launcher, _magazine]];
    };
} forEach configProperties [configFile >> "BWA3_CfgLoadedLaunchers"];

ADDON = true;
