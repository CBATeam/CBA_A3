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
    Original by Karel Moricky, Enhanced by Robalo, jokoho, commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(compatibleItems);

params [["_weapon", "", [""]], ["_typefilter", nil, ["", 0]]];

if (_weapon == "") exitWith {[]};

if (isNil QGVAR(namespace)) then {
    GVAR(namespace) = call CBA_fnc_createNamespace;
};

private _compatibleItems = GVAR(namespace) getVariable _weapon;

if (isNil "_compatibleItems") then {
    _compatibleItems = [];
    private _cfgWeapon = configFile >> "CfgWeapons" >> _weapon;

    if (isClass _cfgWeapon) then {
        {
            private _cfgCompatibleItems = _x >> "compatibleItems";

            if (isArray _cfgCompatibleItems) then {
                {
                    _compatibleItems pushBackUnique _x;
                    nil
                } count getArray _cfgCompatibleItems;
            } else {
                if (isClass _cfgCompatibleItems) then {
                    {
                        if (getNumber _x > 0) then {
                            _compatibleItems pushBackUnique configName _x;
                        };
                        nil
                    } count configProperties [_cfgCompatibleItems, "isNumber _x"];
                };
            };
            nil
        } count configProperties [_cfgWeapon >> "WeaponSlotsInfo", "isclass _x"];

        GVAR(namespace) setVariable [_weapon, _compatibleItems]; //save entry in cache
    } else {
        ["'%1' not found in CfgWeapons", _weapon] call bis_fnc_error;
    };
};

if (isNil "_typefilter") then { //return
    + _compatibleItems
} else {
    if (_typefilter isEqualType "") then {
        _typefilter = [-1, 101, 201, 301, 302] param [["", "muzzle", "optic", "pointer", "bipod"] find _typefilter, -1];
    };

    _compatibleItems select {_typefilter == getNumber (configFile >> "CfgWeapons" >> _x >> "itemInfo" >> "type")}
};
