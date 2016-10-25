/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeItemCargo

Description:
    Removes specific item(s) from cargo space.

Parameters:
    _container - Object with cargo <OBJECT>
    _item      - Classname of item(s) to remove <STRING>
    _count     - Number of item(s) to remove <NUMBER> (Default: 1)

Returns:
    true on success, false otherwise <BOOLEAN>

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

params [["_container", objNull, [objNull]], ["_item", "", [""]], ["_count", 1, [0]]];

private _return = false;

if (isNull _container) exitWith {
    TRACE_2("Container not Object or null",_container,_item);
    _return
};

if (_item isEqualTo "") exitWith {
    TRACE_2("Item not String or empty",_container,_item);
    _return
};

private _config = _item call CBA_fnc_getItemConfig;

if (isNull _config || {getNumber (_config >> "scope") < 1}) exitWith {
    TRACE_2("Item does not exist in Config",_container,_item);
    _return
};

if (_count <= 0) exitWith {
    TRACE_3("Count is not a positive number",_container,_item,_count);
    _return
};

// Ensure proper count
_count = round _count;

// Returns array containing two arrays: [[type1, typeN, ...], [count1, countN, ...]]
(getItemCargo _container) params ["_allItemsType", "_allItemsCount"];

// Clear cargo space and readd the items as long it's not the type in question
clearItemCargoGlobal _container;

{
    private _itemCount = _allItemsCount select _forEachIndex;

    if (_x == _item) then {
        // Process removal
        _return = true;

        _itemCount = _itemCount - _count;
        if (_itemCount > 0) then {
            // Add with new count
            _container addItemCargoGlobal [_x, _itemCount];
        };
    } else {
        // Readd only
        _container addItemCargoGlobal [_x, _itemCount];
    };
} forEach _allItemsType;

_return
