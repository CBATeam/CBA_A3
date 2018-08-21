#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getCompatibleMagazines

Description:
    Retrievs a list of magazines that are compatible with a weapon.

Parameters:
    _weapon           - Weapon configName or config

Example:
    (begin example)
    _mags = ["arifle_MX_SW_F"] call CBA_fnc_getCompatibleMagazines
    (end)

Returns:
    Array of magazine classnames (in config capitalization) <ARRAY>

Author:
    PabstMirror, based on code from Dedmen
---------------------------------------------------------------------------- */
SCRIPT(getCompatibleMagazines);

params [["_weapon", "", ["", configNull]]];

if (_weapon isEqualType "") then {
    _weapon = configFile >> "CfgWeapons" >> _weapon;
};

private _returnMags = getArray (_weapon >> "magazines");

{
    private _wellConfig = configFile >> "CfgMagazineWells" >> _x;
    {
        _returnMags append getArray _x;
    } forEach configProperties [_wellConfig, "isArray _x", true];
} forEach (getArray (_weapon >> "magazineWell"));

private _cfgMagazines = configFile >> "CfgMagazines";
_returnMags = _returnMags select {isClass (_cfgMagazines >> _x)};
_returnMags = _returnMags apply {configName (_cfgMagazines >> _x)};

_returnMags arrayIntersect _returnMags
