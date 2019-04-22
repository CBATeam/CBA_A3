#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_compatibleMagazines

Description:
    Retrieves a list of magazines that are compatible with a weapon.

Parameters:
    _weapon - Weapon configName or config
    _allMuzzles - Get magazines for all muzzles on this weapon (default: false)

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

params [["_weapon", "", ["", configNull]], ["_allMuzzles", false, [false]]];

if (_weapon isEqualType "") then {
    _weapon = configFile >> "CfgWeapons" >> _weapon;
};

private _cacheKey = format ["%1#%2",_weapon,_allMuzzles];

private _returnMags = GVAR(magNamespace) getVariable _cacheKey;

if (isNil "_returnMags") then {
    if (_allMuzzles) then {
        _returnMags = []; // get all mags from all muzzles
        {
            if (_x == "this") then {
                _returnMags append (_weapon call CBA_fnc_compatibleMagazines);
            } else {
                _returnMags append ((_weapon >> _x) call CBA_fnc_compatibleMagazines);
            };
        } forEach getArray (_weapon >> "muzzles");
        _returnMags = _returnMags arrayIntersect _returnMags;
    } else {
        _returnMags = getArray (_weapon >> "magazines"); // get mags just for a specific muzzle
        {
            private _wellConfig = configFile >> "CfgMagazineWells" >> _x;
            {
                _returnMags append getArray _x;
            } forEach configProperties [_wellConfig, "isArray _x", false];
        } forEach (getArray (_weapon >> "magazineWell"));

        private _cfgMagazines = configFile >> "CfgMagazines";
        _returnMags = _returnMags select {isClass (_cfgMagazines >> _x)};
        _returnMags = _returnMags apply {configName (_cfgMagazines >> _x)};
        _returnMags = _returnMags arrayIntersect _returnMags;
    };
    GVAR(magNamespace) setVariable [_cacheKey, _returnMags];
};

+_returnMags
