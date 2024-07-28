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
        _muzzles = "arifle_AK12_GL_F" call CBA_fnc_getMuzzles
        -> ["arifle_AK12_GL_F","EGLM"]
    (end)

Author:
    commy2, johnb43
---------------------------------------------------------------------------- */
SCRIPT(getMuzzles);

params [["_weapon", "", [""]]];

private _config = configFile >> "CfgWeapons" >> _weapon;

if (!isClass _config) exitWith {
    [] // return
};

private _muzzles = [];

// Get config case muzzle names
{
    if (_x == "this") then {
        _muzzles pushBack (configName _config);
    } else {
        if (isClass (_config >> _x)) then {
            _muzzles pushBack (configName (_config >> _x));
        };
    };
} forEach getArray (_config >> "muzzles");

_muzzles // return
