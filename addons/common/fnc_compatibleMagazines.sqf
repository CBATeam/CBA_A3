#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_compatibleMagazines

Description:
    Retrieves a list of magazines that are compatible with a weapon.

Parameters:
    _weapon     - Weapon class name or config <STRING, CONFIG>
    _allMuzzles - Get magazines for all muzzles on this weapon (optional, default: false) <BOOL>

Returns:
    Array of magazine classnames in config capitalization <ARRAY>

Examples:
    (begin example)
        _mags = ["arifle_MX_SW_F"] call CBA_fnc_compatibleMagazines;
        _mags = [configFile >> "CfgWeapons" >> _rifle >> _glMuzzle] call CBA_fnc_compatibleMagazines;
    (end)

Author:
    PabstMirror, based on code from Dedmen
---------------------------------------------------------------------------- */
SCRIPT(compatibleMagazines);

params [["_weapon", "", ["", configNull]], ["_allMuzzles", false, [false]]];

if (_weapon isEqualType "") then {
    _weapon = configFile >> "CfgWeapons" >> _weapon;
};

if (isNil QGVAR(magNamespace)) then {
    GVAR(magNamespace) = createHashMap;
};

private _cacheKey = format ["%1#%2", _weapon, _allMuzzles];
private _returnMags = GVAR(magNamespace) get _cacheKey;

if (isNil "_returnMags") then {
    if (_allMuzzles) then {
        // Get all mags from all muzzles
        _returnMags = [];

        {
            if (_x == "this") then {
                _returnMags append (_weapon call CBA_fnc_compatibleMagazines);
            } else {
                _returnMags append ((_weapon >> _x) call CBA_fnc_compatibleMagazines);
            };
        } forEach getArray (_weapon >> "muzzles");

        _returnMags = _returnMags arrayIntersect _returnMags;
    } else {
        // Get mags just for a specific muzzle
        private _cfgMagazines = configFile >> "CfgMagazines";
        private _cfgMagazineWells = configFile >> "CfgMagazineWells";

        _returnMags = getArray (_weapon >> "magazines");

        private _wellConfig = configNull;

        {
            _wellConfig = _cfgMagazineWells >> _x;

            {
                _returnMags append getArray _x;
            } forEach configProperties [_wellConfig, "isArray _x", false];
        } forEach (getArray (_weapon >> "magazineWell"));

        _returnMags = _returnMags select {isClass (_cfgMagazines >> _x)};
        _returnMags = _returnMags apply {configName (_cfgMagazines >> _x)};
        _returnMags = _returnMags arrayIntersect _returnMags;
    };

    GVAR(magNamespace) set [_cacheKey, _returnMags];
};

+_returnMags
