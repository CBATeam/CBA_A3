/* ----------------------------------------------------------------------------
Function: CBA_fnc_getNonPresetClass

Description:
    Get ancestor class of a weapon or container which has no preset attachments/contents.

Parameters:
    _item       - Lower-cased classname of weapon/container <STRING>
    _configRoot - Root config ("CfgWeapons", "CfgVehicles", ...) <STRING> (Default: "CfgWeapons")

Returns:
    Ancestor class without preset attachments/contents sub-class on success, "" otherwise <STRING>

Examples:
    (begin example)
        // Get parent class without preset attachments of a weapon (returns "arifle_mx_f")
        _ancestorClass = ["arifle_MX_ACO_pointer_F"] call CBA_fnc_getNonPresetClass;
    (end)

Author:
    Jonpas
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(getNonPresetClass);

params [["_class", "", [""]], ["_rootConfig", "CfgWeapons", [""]]];

private _config = configFile >> _rootConfig >> _class;

// Invalid class/root config
if (!isClass _config) exitWith {""};

// Use CBA_fnc_weaponComponents if weapon
if (_rootConfig == "CfgWeapons") exitWith {
    (_class call CBA_fnc_weaponComponents) select 0
};

// Containers
// Create cache if it doesn't exist yet
if (isNil QGVAR(nonPresetClassesCache)) then {
    GVAR(nonPresetClassesCache) = [] call CBA_fnc_createNamespace;
};

private _cachedAncestor = GVAR(nonPresetClassesCache) getVariable _class;

if (isNil "_cachedAncestor") then {
    _cachedAncestor = "";
    while {isClass _config && {getNumber (_config >> "scope") > 0}} do { // Some preset backpacks are scope = 1
        if (count (_config >> "TransportItems") == 0 && {count (_config >> "TransportMagazines") == 0} && {count (_config >> "TransportWeapons") == 0}) exitWith {
            _cachedAncestor = configName _config;
        };
        _config = inheritsFrom _config;
    };

    GVAR(nonPresetClassesCache) setVariable [_class, _cachedAncestor];
};

_cachedAncestor
