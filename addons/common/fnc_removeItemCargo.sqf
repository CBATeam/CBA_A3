/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeItemCargo

Description:
    Removes specific item(s) from local cargo space.

    * Use <CBA_fnc_removeItemCargoGlobal> if you want to remove the item(s) in
      global cargo space.

Parameters:
    _box - Object with cargo [Object]
    _item - Classname of item(s) to remove [String]
    _count - Number of item(s) to remove [Number] (Default: 1)

Returns:
    Success [Boolean]

Examples:
   (begin example)
    // Remove 1 GPS locally from a box
   _success = [myCoolItemBox, "ItemGPS"] call CBA_fnc_removeItemCargo;

   // Remove 2 Compasses locally from a box
   _success = [myCoolItemBox, "ItemCompass", 2] call CBA_fnc_removeItemCargo;
   (end)

Author:
    Jonpas
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(removeItemCargo);

params ["_box", "_item", ["_count", 1]];

if (typeName _box != "OBJECT") exitWith {
    TRACE_2("Box not Object",_box,_item);
    false
};
if (typeName _item != "STRING") exitWith {
    TRACE_2("Item not String",_box,_item);
    false
};
if (isNull _box) exitWith {
    TRACE_2("Box isNull",_box,_item);
    false
};
if (_item == "") exitWith {
    TRACE_2("Empty Item",_box,_item);
    false
};
if !(isClass (configFile >> "CfgWeapons" >> _item)) exitWith {
    TRACE_2("Item does not exist in the game config",_box,_item);
    false
};
if (typeName _count != "SCALAR") exitWith {
    TRACE_3("Count is not a number",_box,_item,_count);
    false
};
if (_count <= 0) exitWith {
    TRACE_3("Count is not a positive number",_box,_item,_count);
    false
};

// Ensure proper count
_count = round _count;

// Returns array containing two arrays: [[type1, typeN, ...], [count1, countN, ...]]
(getItemCargo _box) params ["_allItemsType", "_allItemsCount"];

// Clear cargo space and readd the items as long it's not the type in question
private _returnVar = false;
clearItemCargo _box;
{
    private _itemCount = _allItemsCount select _forEachIndex;

    if (_x == _item) then {
        // Process removal
        _returnVar = true;

        _itemCount = _itemCount - _count;
        if (_itemCount > 0) then {
            // Add with new count
            _box addItemCargo [_x, _itemCount];
        };
    } else {
        // Readd only
        _box addItemCargo [_x, _itemCount];
    };
} forEach _allItemsType;

_returnVar
