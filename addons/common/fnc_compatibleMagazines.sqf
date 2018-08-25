#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_compatibleMagazines

Description:
    Retrieves a list of magazines that are compatible with a weapon.

Parameters:
    _weapon           - Weapon configName or config

Example:
    (begin example)
    _mags = ["arifle_MX_SW_F"] call CBA_fnc_compatibleMagazines
    _mags = [configFile >> "CfgWeapons" >> _rifle >> _glMuzzle] call CBA_fnc_compatibleMagazines
    (end)

Returns:
    Array of magazine classnames in config capitalization  <ARRAY>

Author:
    PabstMirror, based on code from Dedmen
---------------------------------------------------------------------------- */
SCRIPT(compatibleMagazines);

params [["_weapon", "", ["", configNull]]];

if (_weapon isEqualType "") then {
    _weapon = configFile >> "CfgWeapons" >> _weapon;
};

private _cacheKey = str _weapon;
if (_cacheKey == "") exitWith { ERROR_1("Weapon Does Not Exist %1",_this); [] };

if (isNil QGVAR(magNamespace)) then { GVAR(magNamespace) = call CBA_fnc_createNamespace; };

private _returnMags = GVAR(magNamespace) getVariable _cacheKey;

if (isNil "_returnMags") then {
    _returnMags = getArray (_weapon >> "magazines");
    {
        private _wellConfig = configFile >> "CfgMagazineWells" >> _x;
        {
            _returnMags append getArray _x;
        } forEach configProperties [_wellConfig, "isArray _x", true];
    } forEach (getArray (_weapon >> "magazineWell"));

    private _cfgMagazines = configFile >> "CfgMagazines";
    _returnMags = _returnMags select {isClass (_cfgMagazines >> _x)};
    _returnMags = _returnMags apply {configName (_cfgMagazines >> _x)};
    _returnMags = _returnMags arrayIntersect _returnMags;

    GVAR(magNamespace) setVariable [_cacheKey, _returnMags];
};

+_returnMags
