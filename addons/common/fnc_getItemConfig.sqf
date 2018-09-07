#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getItemConfig

Description:
    A function used to return the config of an item.

Parameters:
    _weapon - Any kind of item, weapon or magazine class name <STRING>

Returns:
    _config - Item config. <CONFIG>

Example:
    (begin example)
        _config = currentWeapon player call CBA_fnc_getItemConfig;
        (currentMagazine cameraOn) call CBA_fnc_getItemConfig;
        (goggles player) call CBA_fnc_getItemConfig;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
SCRIPT(getItemConfig);

params [["_weapon", "", [""]]];

private _result = configNull;

{
    private _config = configFile >> _x >> _weapon;

    if (isClass _config) exitWith {
        _result = _config;
    };
} forEach ["CfgWeapons", "CfgMagazines", "CfgGlasses"];

_result
