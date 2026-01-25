#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_weaponComponents

Description:
    Reports class name of base weapon without attachments and all attachments belonging to a pre equipped weapon.

    Base weapon and attachments are reported in lower case capitalization.
    Fixed version of BIS_fnc_weaponComponents.

Parameters:
    _weapon - a weapons class name with attachments build in <STRING>

Returns:
    _components - class names of base weapon + attachments. <ARRAY>
        attachments are in random order, but weapon is always at first position
        empty array if weapon does not exist in config

Examples:
    (begin example)
        _components = (primaryWeapon player) call CBA_fnc_weaponComponents;
    (end)

Author:
    commy2, based on BIS_fnc_weaponComponents by Jiri Wainar
---------------------------------------------------------------------------- */
SCRIPT(weaponComponents);

params [["_weapon", "", [""]]];

if (isNil QGVAR(weaponComponentsCache)) then {
    GVAR(weaponComponentsCache) = [] call CBA_fnc_createNamespace;
};

private _components = GVAR(weaponComponentsCache) getVariable _weapon;

if (isNil "_components") then {
    private _config = configFile >> "CfgWeapons" >> _weapon;

    // Return empty array if the weapon doesn't exist
    if (!isClass _config) exitWith {
        _components = [];
    };

    // get attachments
    private _attachments = [];
    {
        _attachments pushBack toLower getText (_x >> "item");
    } forEach ("true" configClasses (_config >> "LinkedItems")); // inheritance is apparently disabled for these

    // get first parent without attachments
    private _baseWeapon = "";
    while {isClass _config && {getNumber (_config >> "scope") > 0}} do { // Some preset weapons are scope = 1
        if (count (_config >> "LinkedItems") == 0) exitWith {
            _baseWeapon = configName _config;
        };

        _config = inheritsFrom _config;
    };

    _components = [toLower _baseWeapon];
    _components append _attachments;

    GVAR(weaponComponentsCache) setVariable [_weapon, _components];
};

+_components
