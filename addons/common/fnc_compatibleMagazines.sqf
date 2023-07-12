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
    PabstMirror, johnb43, based on code from Dedmen
---------------------------------------------------------------------------- */
SCRIPT(compatibleMagazines);

params [["_weapon", "", ["", configNull]], ["_allMuzzles", false, [false]]];

if (_weapon isEqualType "") then {
    _weapon = configFile >> "CfgWeapons" >> _weapon;
};

if (isNil QGVAR(magNamespace)) then {
    GVAR(magNamespace) = createHashMap;
};

+(GVAR(magNamespace) getOrDefaultCall [format ["%1#%2", _weapon, _allMuzzles], {
    if (_allMuzzles) then {
         // Get all mags from all muzzles
        private _returnMags = createHashMap;

        {
            if (_x == "this") then {
                _returnMags insert [true, _weapon call CBA_fnc_compatibleMagazines, []];
            } else {
                _returnMags insert [true, (_weapon >> _x) call CBA_fnc_compatibleMagazines, []];
            };
        } forEach getArray (_weapon >> "muzzles");

        keys _returnMags
    } else {
        // Get mags just for a specific muzzle
        private _cfgMagazines = configFile >> "CfgMagazines";
        private _cfgMagazineWells = configFile >> "CfgMagazineWells";
        private _returnMags = getArray (_weapon >> "magazines") createHashMapFromArray [];

        {
            {
                _returnMags insert [true, (getArray _x) apply {configName (_cfgMagazines >> _x)}, []];
            } forEach configProperties [_cfgMagazineWells >> _x, "isArray _x", false];
        } forEach (getArray (_weapon >> "magazineWell"));

        // Delete invalid entry
        _returnMags deleteAt "";

        keys _returnMags
    };
}, true])
