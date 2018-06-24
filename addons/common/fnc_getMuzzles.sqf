#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getMuzzles

Description:
    Gets the list of possible muzzles for a weapon.

Parameters:
    _weapon - class name of the weapon to examine <STRING>

Returns:
    _muzzles - All muzzle names <ARRAY>

Examples:
    (begin example)
        _muzzles = "M4A1_RCO_GL" call CBA_fnc_determineMuzzles
        -> ["M4_ACOG_Muzzle", "M203Muzzle"]
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
SCRIPT(getMuzzles);

params [["_weapon", "", [""]]];

private _muzzles = getArray (configFile >> "CfgWeapons" >> _weapon >> "muzzles");

{
    if (_x == "this") then {
        _muzzles set [_forEachIndex, _weapon];
    };
} forEach _muzzles;

_muzzles
