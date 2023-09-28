#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_compatibleItems

Description:
    Return all compatible weapon attachments.

Parameters:
    _weapon     - A weapons class name <STRING>
    _typefilter - Optional filter. Can be "muzzle", "optic", "pointer" or "bipod". <STRING, NUMBER>

Returns:
    Class names of attachments compatible with weapon <ARRAY>

Examples:
    (begin example)
        _acclist = ["LMG_Mk200_F"] call CBA_fnc_compatibleItems;
        _muzzleacclist = ["LMG_Mk200_F", "muzzle"] call CBA_fnc_compatibleItems;
    (end)

Author:
    Original by Karel Moricky, Enhanced by Robalo, jokoho, commy2, johnb43
---------------------------------------------------------------------------- */
SCRIPT(compatibleItems);

params [["_weapon", "", [""]], ["_typefilter", nil, ["", 0]]];

if (_weapon == "") exitWith {[]};

private _cfgWeapons = configFile >> "CfgWeapons";
private _weaponConfig = _cfgWeapons >> _weapon;

// Check if weapon exists
if !(isClass _weaponConfig) exitWith {
    ["'%1' not found in CfgWeapons", _weapon] call BIS_fnc_error;

    []
};

private _typeFilterExists = !isNil "_typefilter";

// Convert filter into number (if string)
if (_typeFilterExists && {_typefilter isEqualType ""}) then {
    _typefilter = [-1, 101, 201, 301, 302] param [["", "muzzle", "optic", "pointer", "bipod"] find _typefilter, -1];
};

// Check if valid type filter
if (_typeFilterExists && {!(_typefilter in [101, 201, 301, 302])}) exitWith {[]};

if (isNil QGVAR(namespace)) then {
    GVAR(namespace) = createHashMap;
};

// Get cached result, if it exists
private _cachekey = format ["%1#%2", _weapon, ["all", _typefilter] select _typeFilterExists];
private _compatibleItems = GVAR(namespace) get _cachekey;

if (!isNil "_compatibleItems") exitWith {
    +_compatibleItems
};

if (_typeFilterExists) then {
    // Get all compatible weapon attachments, then filter
    _compatibleItems = _weapon call CBA_fnc_compatibleItems;
    _compatibleItems = _compatibleItems select {_typefilter == getNumber (_cfgWeapons >> _x >> "itemInfo" >> "type")};
} else {
    _compatibleItems = [];

    {
        private _cfgCompatibleItems = _x >> "compatibleItems";

        if (isArray _cfgCompatibleItems) then {
            {
                // Ensure item class name is in config case
                _compatibleItems pushBackUnique configName (_cfgWeapons >> _x);
            } forEach getArray _cfgCompatibleItems;
        } else {
            if (isClass _cfgCompatibleItems) then {
                {
                    if (getNumber _x > 0) then {
                        // Ensure item class name is in config case
                        _compatibleItems pushBackUnique configName (_cfgWeapons >> configName _x);
                    };
                } forEach configProperties [_cfgCompatibleItems, "isNumber _x"];
            };
        };
    } forEach configProperties [_weaponConfig >> "WeaponSlotsInfo", "isClass _x"];

    // Remove non-existent item(s)
    _compatibleItems deleteAt (_compatibleItems find "");
};

// Cache result
GVAR(namespace) set [_cachekey, _compatibleItems];

+_compatibleItems
