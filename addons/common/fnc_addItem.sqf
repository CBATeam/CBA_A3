#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_addItem

Description:
    Add an item to a unit.

    Function which verifies existence of _item and _unit, returns false in
    case of trouble, or when able to add _item to _unit true in case of success.

Parameters:
    _unit   - the unit <OBJECT>
    _item   - name of the weapon to add <STRING>
    _verify - if true, then put item in vehicle or on the ground if it can't be added <BOOLEAN>

Returns:
    true on success, false otherwise <BOOLEAN>

Examples:
    (begin example)
        _result = [player, "Binocular"] call CBA_fnc_addItem
    (end)

Author:

---------------------------------------------------------------------------- */
SCRIPT(addItem);

params [["_unit", objNull, [objNull]], ["_item", "", [""]], ["_verify", false, [false]]];

private _return = false;

if (isNull _unit) exitWith {
    TRACE_2("Unit not Object or null",_unit,_item);
    _return
};

if (_item isEqualTo "") exitWith {
    TRACE_2("Item not String or empty",_unit,_item);
    _return
};

private _config = _item call CBA_fnc_getItemConfig;

if (isNull _config || {getNumber (_config >> "scope") < 1}) exitWith {
    TRACE_2("Item does not exist in Config",_unit,_item);
    _return
};

if (_verify) then {
    if (_unit canAdd [_item, 1, true]) then {
        _unit addItem _item;
        _return = true;
    } else {
        private _vehicle = vehicle _unit;
        if (_vehicle isEqualTo _unit) then {
            _unit switchMove "ainvpknlmstpslaywrfldnon_1";

            private _weaponHolder = nearestObject [_unit, "WeaponHolder"];

            if (isNull _weaponHolder || {_unit distance _weaponHolder > 2}) then {
                _weaponHolder = createVehicle ["GroundWeaponHolder", [0,0,0], [], 0, "NONE"];
                _weaponHolder setPosASL getPosASL _unit;
            };

            [_weaponHolder, _item, 1, _verify] call CBA_fnc_addItemCargo;
        } else {
            [_vehicle, _item, 1, _verify] call CBA_fnc_addItemCargo;
        };
    };
} else {
    _unit addItem _item;
    _return = true;
};

_return
