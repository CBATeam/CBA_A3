#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: cba_disposable_fnc_replaceMagazineCargo

Description:
    Replaces disposable launcher magazines with loaded disposable launchers.

Parameters:
    _containerType - typeOf _container <STRING>
    _container - Any object with cargo <OBJECT>

Returns:
    Nothing.

Examples:
    (begin example)
        [typeOf _container, _container] call cba_disposable_fnc_replaceMagazineCargo
    (end)

Author:
    commy2, johnb43
---------------------------------------------------------------------------- */

if (!GVAR(replaceDisposableLauncher)) exitWith {};
if (missionNamespace getVariable [QGVAR(disableMagazineReplacement), false]) exitWith {};

params ["_containerType", "_container"];

if (!local _container) exitWith {};

private _containers = everyContainer _container;

if (_container isKindOf "CAManBase") then {
    _containers append ([
        [uniform _container, uniformContainer _container],
        [vest _container, vestContainer _container],
        [backpack _container, backpackContainer _container]
    ] select {!isNull (_x select 1)});
};

// Replace all magazines recursively
{
    _x call FUNC(replaceMagazineCargo);
} forEach _containers;

private _magazines = (magazineCargo _container) select {_x in GVAR(magazines)};

if (_magazines isEqualTo []) exitWith {};

// Check if a uniform, vest, backpack or something else entirely
_containerType = if (getNumber (configOf _container >> "isBackpack") == 1) then {
    TYPE_BACKPACK
} else {
    // If uniform or vest, this config will be defined, otherwise it will default to 0
    getNumber (configFile >> "CfgWeapons" >> _containerType >> "ItemInfo" >> "type")
};

// Replace magazines with disposable launchers
{
    _container addMagazineCargoGlobal [_x, -1];

    private _loadedLauncher = GVAR(MagazineLaunchers) getVariable _x;

    // Slot restrictions only apply if uniform, vest or backpack
    // If slot restrictions apply, remove magazine but don't add weapon
    if (_containerType == 0 || {_containerType in (GVAR(allowedSlotsLaunchers) getOrDefault [_loadedLauncher, []])}) then {
        _container addWeaponCargoGlobal [_loadedLauncher, 1];
    };
} forEach _magazines;
