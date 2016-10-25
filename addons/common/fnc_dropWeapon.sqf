/* ----------------------------------------------------------------------------
Function: CBA_fnc_dropWeapon

Description:
    Drops a weapon.

    Function which verifies existence of _item and _unit, returns false in case
    of trouble, or when able to remove _item from _unit true in case of success

Parameters:
    _unit - the unit that should drop a weapon <OBJECT>
    _item - class name of the weapon to drop <STRING>

Returns:
    true if successful, false otherwise <BOOLEAN>

Examples:
    (begin example)
        _result = [player, primaryWeapon player] call CBA_fnc_dropWeapon
    (end)

Author:
    ?, commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(dropWeapon);

params [["_unit", objNull, [objNull]], ["_item", "", [""]]];

private _weaponInfo = (weaponsItems _unit select {_x select 0 == _item}) param [0, []];
private _return = [_unit, _item] call CBA_fnc_removeWeapon;

if (_return) then {
    private _baseWeapon = _item call CBA_fnc_weaponComponents param [0, _item];

    private _items = _weaponInfo;
    _items deleteAt 0; // delete the weapon

    private _magazines = [];

    {
        if (_x isEqualType []) then {
            _magazines pushBack _x;
            _items set [_forEachIndex, ""];
        };
    } forEach _items;

    _items = _items - [""];

    _unit switchMove "ainvpknlmstpslaywrfldnon_1";

    private _weaponHolder = nearestObject [_unit, "WeaponHolder"];

    if (isNull _weaponHolder || {_unit distance _weaponHolder > 2}) then {
        _weaponHolder = createVehicle ["GroundWeaponHolder", [0,0,0], [], 0, "NONE"];
        _weaponHolder setPosASL getPosASL _unit;
    };

    _weaponHolder addWeaponCargoGlobal [_baseWeapon, 1];

    {
        _weaponHolder addItemCargoGlobal [_x, 1];
    } forEach _items;

    {
        _weaponHolder addMagazineAmmoCargo [_x select 0, 1, _x select 1];
    } forEach _magazines;
};

_return
