#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getCargoDeep
Description:
    Gets the full inventory of a given object.

Parameters:
    _object  - Object to get the inventory of <OBJECT>

Returns:
    Object's inventory <ARRAY>

Examples
    (begin example)
        cursorObject call CBA_fnc_getCargoDeep
    (end)

Author:
    DartRuffian
---------------------------------------------------------------------------- */

params [
    ["_object", objNull, [objNull]]
];
TRACE_1("fnc_getCargoDeep",_object);

// Formats [["abc", "def"], [1, 2]] as [["abc", 1], ["def", 2]]
private _fnc_formatCounts = {
    params ["_classes", "_counts"];
    if (count _classes != count _counts) exitWith {
        ERROR_2("Item counts have mismatched lengths! items='%1', counts='%2'",_classes,_counts);
        [];
    };

    private _return = [];
    {
        _return pushBack [_x, _counts select _forEachIndex];
    } forEach _classes;
    _return;
};

// itemType does a lot of lookups, so cache the results
private _itemTypeCache = createHashMap;
private _fnc_getItemType = {
    _itemTypeCache getOrDefaultCall [_this, {
        (call BIS_fnc_itemType) param [1, ""];
    }, true];
};

private _return = [];

private _weapons = [];
{
    private _currWeapon = _x;
    _currWeapon params ["_weapon", "_muzzle", "_pointer", "_scope", "_magazine1", "_magazine2", "_bipod"];
    private _index = _weapons findIf {
        _currWeapon isEqualTo (_x select 0); // Must be an exact match
    };
    if (_index > -1) then {
        _weapons set [_index, [_currWeapon, ((_weapons select _index) select 1) + 1]];
    } else {
        _weapons pushBack [_currWeapon, 1];
    };
} forEach (weaponsItemsCargo _object);
_return pushBack _weapons;

private _magazines = [];
{
    _x params ["_class", "_ammoCount"];
    // Check if there's already a magazine with the same ammo count
    private _index = _magazines findIf {
        _x params ["_xClass", "", "_xAmmoCount"];
        _class == _xClass && _ammoCount == _xAmmoCount
    };

    if (_index > -1) then {
        // Already exists, +1 to quantity
        _magazines set [_index, [
            _class, ((_magazines select _index) select 1) + 1, _ammoCount
        ]];
    } else {
        _magazines pushBack [_class, 1, _ammoCount];
    };
} forEach (magazinesAmmoCargo _object);
_return pushBack _magazines;

_return pushBack ((getItemCargo _object) call _fnc_formatCounts);

// Not sure how deep inventories can go
private _containers = [];
{
    _x params ["_class", "_container"];
    _containers pushBack [_class, _class call _fnc_getItemType, _container call CBA_fnc_getCargoDeep];
} forEach (everyContainer _object);
_return pushBack _containers;

_return;
