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

if (isNil "_typefilter") exitWith {
	compatibleItems _weapon
};

if (_typefilter isEqualType "") then {
	_typefilter = [-1, 101, 201, 301, 302] param [["", "muzzle", "optic", "pointer", "bipod"] findIf {_x == _typefilter}, -1];
};

if (_typefilter == -1) exitWith {[]};

if (isNil QGVAR(namespace)) then {
	GVAR(namespace) = createHashMap;
};

private _cacheKey = format ["%1#%2", _weapon, _typeFilter];
_compatibleItems = GVAR(namespace) get _cacheKey;

if (isNil "_compatibleItems") then {
    private _cfgWeapons = configFile >> "CfgWeapons";
    _compatibleItems = (compatibleItems _weapon) select {_typefilter == getNumber (_cfgWeapons >> _x >> "itemInfo" >> "type")};

    GVAR(namespace) set [_cacheKey, _compatibleItems];
};

_compatibleItems
