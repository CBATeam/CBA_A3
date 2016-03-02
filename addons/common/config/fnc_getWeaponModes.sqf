/* ----------------------------------------------------------------------------
Function: CBA_fnc_getWeaponModes

Description:
    Gets the list of possible modes for a weapon.

Parameters:
    _weapon        - class name of the weapon to examine <STRING>
    _includeHidden - true - report AI only modes, false - report player modes (default: false) <BOOLEAN>

Returns:
    _modes - All weapon mode names <ARRAY>

Examples:
    (begin example)
        _modes = "M4A1_RCO_GL" call CBA_fnc_getWeaponModes
        -> ["M4_ACOG_Muzzle", "M203Muzzle"]
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(getWeaponModes);

params [["_weapon", "", [""]], ["_includeHidden", false, [false]]];

private _config = configFile >> "CfgWeapons" >> _weapon;

private _modes = [];

{
    if (_includeHidden || {getNumber (_config >> _x >> "showToPlayer") == 1}) then {
        if (_x == "this") then {
            _modes pushBack _weapon;
        } else {
            _modes pushBack _x;
        };
    };
} forEach getArray (_config >> "modes");

_modes
