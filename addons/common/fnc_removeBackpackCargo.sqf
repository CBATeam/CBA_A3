/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeBackpackCargo

Description:
    Removes specific backpack(s) from local cargo space.
    Warning: Backpack's inventory information is lost.

    * Use <CBA_fnc_removeBackpackCargoGlobal> if you want to remove the backpack(s) in
      global cargo space.

Parameters:
    _box - Object with cargo [Object]
    _item - Classname of backpack(s) to remove [String]
    _count - Number of backpack(s) to remove [Number] (Default: 1)

Returns:
    Success [Boolean]

Examples:
   (begin example)
    // Remove 1 Kitbag Tan backpack locally from a box
   _success = [myCoolBackpackBox, "B_Kitbag_cbr"] call CBA_fnc_removeBackpackCargo;

   // Remove 2 Carryall Desert Camo backpacks locally from a box
   _success = [myCoolBackpackBox, "B_Carryall_ocamo", 2] call CBA_fnc_removeBackpackCargo;
   (end)

Author:
    Jonpas
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(removeBackpackCargo);

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
if !(isClass (configFile >> "CfgVehicles" >> _item)) exitWith {
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
(getBackpackCargo _box) params ["_allItemsType", "_allItemsCount"];

// Clear cargo space and readd the items as long it's not the type in question
private "_returnVar"; _returnVar = false;
clearBackpackCargo _box;
{
    private "_itemCount"; _itemCount = _allItemsCount select _forEachIndex;

    if (_x == _item) then {
        // Process removal
        _returnVar = true;

        _itemCount = _itemCount - _count;
        if (_itemCount > 0) then {
            // Add with new count
            _box addBackpackCargo [_x, _itemCount];
        };
    } else {
        // Readd only
        _box addBackpackCargo [_x, _itemCount];
    };
} forEach _allItemsType;

_returnVar
