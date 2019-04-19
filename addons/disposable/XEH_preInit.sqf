#include "script_component.hpp"

ADDON = false;

if (configProperties [configFile >> "CBA_DisposableLaunchers"] isEqualTo []) exitWith {};

private _fnc_update = {
    params ["_unit"];
    if (!local _unit) exitWith {};
    (GVAR(NormalLaunchers) getVariable secondaryWeapon _unit) params ["_launcher", "_magazine"];

    if (!isNil "_launcher") then {
        private _launcherItems = secondaryWeaponItems _unit;
        private _launcherMagazines = [_magazine] + (secondaryWeaponMagazine _unit select [1, 1e7]);

        _unit addWeapon _launcher;
        {
            _unit addSecondaryWeaponItem _x;
        } forEach _launcherItems;

        {
            _unit addWeaponItem [_launcher, _x];
        } forEach _launcherMagazines;
    };
};

["loadout", _fnc_update] call CBA_fnc_addPlayerEventHandler;
["CAManBase", "InitPost", _fnc_update] call CBA_fnc_addClassEventHandler;
["CAManBase", "Take", _fnc_update] call CBA_fnc_addClassEventHandler;

// Arsenal
[QGVAR(arsenalOpened), {
    private _unit = call CBA_fnc_currentUnit;
    private _launcher = GVAR(LoadedLaunchers) getVariable secondaryWeapon _unit;

    if (!isNil "_launcher") then {
        private _launcherItems = secondaryWeaponItems _unit;
        private _launcherMagazines = secondaryWeaponMagazine _unit select [1, 1e7];

        _unit addWeapon _launcher;
        {
            _unit addSecondaryWeaponItem _x;
        } forEach _launcherItems;

        {
            _unit addWeaponItem [_launcher, _x];
        } forEach _launcherMagazines;
    };
}] call CBA_fnc_addEventHandler;

[missionNamespace, "arsenalOpened", {
    isNil {
        QGVAR(arsenalOpened) call CBA_fnc_localEvent;
    };
}] call BIS_fnc_addScriptedEventHandler;

//["ace_arsenal_displayOpened", _fnc_arsenalOpened] call CBA_fnc_addEventHandler;

GVAR(NormalLaunchers) = [] call CBA_fnc_createNamespace;
GVAR(LoadedLaunchers) = [] call CBA_fnc_createNamespace;
GVAR(UsedLaunchers) = [] call CBA_fnc_createNamespace;

{
    private _launcher = configName _x;
    private _magazine = getArray (configFile >> "CfgWeapons" >> _launcher >> "magazines") select 0;
    getArray _x params ["_loadedLauncher", "_usedLauncher"];

    GVAR(LoadedLaunchers) setVariable [_launcher, _loadedLauncher];
    GVAR(UsedLaunchers) setVariable [_launcher, _usedLauncher];

    if (isNil {GVAR(NormalLaunchers) getVariable _loadedLauncher}) then {
        GVAR(NormalLaunchers) setVariable [_loadedLauncher, [_launcher, _magazine]];
    };
} forEach configProperties [configFile >> "CBA_DisposableLaunchers", "isArray _x"];

ADDON = true;
