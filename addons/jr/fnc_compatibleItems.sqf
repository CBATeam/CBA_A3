/*
    Author: Karel Moricky
    Enhanced by Robalo
    adding Caching by joko // Jonas

    Description:
    Return all compatible weapon attachments

    Parameter(s):
        0: STRING - weapon class
        1: STRING - optional, accessory type: number (101 - muzzle, 201 - optic, 301 - pointer, 302 - bipod)

    Returns:
        ARRAY of STRINGs

    Examples:
        _acclist = ["LMG_Mk200_F"] call CBA_fnc_compatibleItems;
        _muzzleacclist = ["LMG_Mk200_F", 101] call CBA_fnc_compatibleItems;
*/
#include "script_component.hpp"
params [["_weapon", "", [""]], ["_typefilter", 0]];
if (_weapon == "") exitWith {[]};

if (isNil QGVAR(namespace)) then {
    GVAR(namespace) = call CBA_fnc_createNamespace;
};
private _compatibleItems = GVAR(namespace) getVariable format [QGVAR(cached_%1), _weapon];

if (isNil "_compatibleItems") then {
    private ["_cfgWeapon"];
    _cfgWeapon = configfile >> "cfgweapons" >> _weapon;
    if (isClass _cfgWeapon) then {
        private ["_compatibleItems"];
        _compatibleItems = [];
        {
            private ["_cfgCompatibleItems"];
            _cfgCompatibleItems = _x >> "compatibleItems";
            if (isArray _cfgCompatibleItems) then {
                {
                    if !(_x in _compatibleItems) then {_compatibleItems pushBack _x;};
                    nil
                } count (getArray _cfgCompatibleItems);
            } else {
                if (isclass _cfgCompatibleItems) then {
                    {
                        if (getnumber _x > 0 && {!((configname _x) in _compatibleItems)}) then {_compatibleItems pushBack (configname _x)};
                        nil
                    } count configproperties [_cfgCompatibleItems, "isNumber _x"];
                };
            };
            nil
        } count configproperties [_cfgWeapon >> "WeaponSlotsInfo","isclass _x"];

    } else {
        ["'%1' not found in CfgWeapons",_weapon] call bis_fnc_error;
        []
    };
} else {
    if (_typefilter == 0) then {
        _compatibleItems
    } else {
        // repace for 1.56 with _compatibleItems select {_typefilter == getNumber(configfile>>"cfgweapons">>_x>>"itemInfo">>"type")};
        [_compatibleItems, {_typefilter == getNumber(configfile>>"cfgweapons">>_x>>"itemInfo">>"type")}] call BIS_fnc_conditionalSelect;
    };
};
