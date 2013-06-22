/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeWeaponCargo

Description:
    Function to remove specific items from local cargo space.

    * Use <CBA_fnc_removeWeaponCargoGlobal> if you want to remove the item in
      global mission space.

Parameters:
    _unit - the vehicle providing cargo space [Object]
    _item - classname of item to remove [String]
    _count - number of items to remove [Number] (Default: 1)

Returns:
    true on success, false otherwise (error or no such item in cargo)

Examples:
   (begin example)
   // remove 1 Binocular locally from the box
   _success = [myCoolWeaponBox, "Binocular"] call CBA_fnc_removeWeaponCargo;

   // remove 2 M16A2 locally from the box
   _success = [myCoolWeaponBox, "M16A2", 2] call CBA_fnc_removeWeaponCargo;
   (end)

Author:
    silencer.helling3r 2012-12-22
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(removeWeaponCargo);

PARAMS_2(_unit,_item);
DEFAULT_PARAM(2,_count,1);

if (typeName _unit != "OBJECT") exitWith
{
    TRACE_2("Unit not Object",_unit,_item);
    false
};
if (typeName _item != "STRING") exitWith
{
    TRACE_2("Item not String",_unit,_item);
    false
};
if (isNull _unit) exitWith
{
    TRACE_2("Unit isNull",_unit,_item);
    false
};
if (_item == "") exitWith
{
    TRACE_2("Empty Item",_unit,_item);
    false
};
if !(isClass (configFile >> "CfgWeapons" >> _item)) exitWith
{
    TRACE_2("Item does not exist in the game config",_unit,_item);
    false
};
if (typeName _count != "SCALAR") exitWith
{
    TRACE_3("Count is not a number",_unit,_item,_count);
    false
};
if (_count <= 0) exitWith
{
    TRACE_3("Count is not a positive number",_unit,_item,_count);
    false
};
_count=round _count;    // ensure proper count

private ["_i", "_unit_allItems", "_unit_allItems_types", "_unit_allItems_count", "_item_type", "_item_count", "_returnVar"];

// returns array containing two arrays: [[type1, typeN, ...],[count1, countN, ...]]
_unit_allItems = getWeaponCargo _unit;
_unit_allItems_types = _unit_allItems select 0;
_unit_allItems_count = _unit_allItems select 1;

/*
 * Clear cargo space and readd the items as long its not the type in question.
 * If it is the requested class, we cannot just substract items because of the
 * count parameter.
 */
_returnVar = false;
clearWeaponCargo _unit;
for "_i" from 0 to (count _unit_allItems_types) - 1 do
{
    _item_type = _unit_allItems_types select _i;
    _item_count = _unit_allItems_count select _i;
    if (_item_type == _item) then
    {
        // process removal
        _returnVar = true;

        _item_count = _item_count - _count;
        if (_item_count > 0) then
        {
            // add with new count
            _unit addWeaponCargo [_item_type, _item_count];
        };
    }
    else
    {
        // just readd item
        _unit addWeaponCargo [_item_type, _item_count];
    };
};
true

