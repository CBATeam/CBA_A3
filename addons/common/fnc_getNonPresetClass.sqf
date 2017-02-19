/* ----------------------------------------------------------------------------
Function: CBA_fnc_getNonPresetClass

Description:
    Get ancestor class of a weapon or container which has no preset attachments/contents.

Parameters:
    _item       - Classname of weapon/container <STRING>
    _configRoot - Root config ("CfgWeapons", "CfgVehicles", ...) <STRING> (Default: "CfgWeapons")

Returns:
    Ancestor class without preset attachments/contents sub-class on success, "" otherwise <STRING>

Examples:
    (begin example)
        // Get parent class without preset attachments of a weapon (returns "arifle_MX_F")
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
if (!isClass _config) exitWith {
    _class
};

// Return current class - has no preset attachments/contents
if (
    // CfgWeapons
    (configProperties [_config >> "LinkedItems", "isClass _x", true] isEqualTo []) &&
    // CfgVehicles
    {configProperties [_config >> "TransportItems", "isClass _x", true] isEqualTo []} &&
    {configProperties [_config >> "TransportMagazines", "isClass _x", true] isEqualTo []} &&
    {configProperties [_config >> "TransportWeapons", "isClass _x", true] isEqualTo []}
) exitWith {
    _class
};

// Check parent
private _parent = inheritsFrom _config;
if (_parent isEqualTo configNull) then {
    // We reached configNull, stuff must be invalid, return empty string
    ""
} else {
    // Recursively search the ancestor tree
    [configName _parent, _rootConfig] call CBA_fnc_getNonPresetClass;
};
