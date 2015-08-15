/* ----------------------------------------------------------------------------
Function: CBA_fnc_addWeapon

Description:
    Add a weapon to a unit.

    Function which verifies existence of _item and _unit, returns false in
    case of trouble, or when able to add _item to _unit true in case of success.

Parameters:
    _unit - the unit
    _item - name of the weapon to add

Returns:
    true on success, false otherwise

Examples:
    (begin example)
    _result = [player, "Binocular"] call CBA_fnc_addWeapon
    (end)

Author:

---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(addWeapon);

#define __scriptname fAddWeapon

#define __cfg (configFile >> "CfgWeapons")
#define __action addWeapon

params ["_unit","_item"];
if (typeName _unit != "OBJECT") exitWith {
    TRACE_2("Unit not Object",_unit,_item);
    false
};
if (typeName _item != "STRING") exitWith {
    TRACE_2("Item not String",_unit,_item);
    false
};
if (isNull _unit) exitWith {
    TRACE_2("Unit isNull",_unit,_item);
    false
};
if (_item == "") exitWith {
    TRACE_2("Empty Item",_unit,_item);
    false
};
if !(isClass (__cfg >> _item)) exitWith {
    TRACE_2("Item not exist in Config",_unit,_item);
    false
};
_unit __action _item;
TRACE_2("Success",_unit,_item);
true
