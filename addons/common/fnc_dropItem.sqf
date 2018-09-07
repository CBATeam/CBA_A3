#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_dropItem

Description:
    Drops an item.

    Function which verifies existence of _item and _unit, returns false in case
    of trouble, or when able to remove _item from _unit true in case of success

Parameters:
    _unit - the unit that should drop the item <OBJECT>
    _item - class name of the item to drop <STRING>

Returns:
    true if successful, false otherwise <BOOLEAN>

Examples:
    (begin example)
        _result = [player, "FirstAidKit"] call CBA_fnc_dropItem
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
SCRIPT(dropItem);

params [["_unit", objNull, [objNull]], ["_item", "", [""]]];

private _return = [_unit, _item] call CBA_fnc_removeItem;

if (_return) then {
    _unit switchMove "ainvpknlmstpslaywrfldnon_1";

    private _weaponHolder = nearestObject [_unit, "WeaponHolder"];

    if (isNull _weaponHolder || {_unit distance _weaponHolder > 2}) then {
        _weaponHolder = createVehicle ["GroundWeaponHolder", [0,0,0], [], 0, "NONE"];
        _weaponHolder setPosASL getPosASL _unit;
    };

    _weaponHolder addItemCargoGlobal [_item, 1];
};

_return
