/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeItem

Description:
    Remove an item.

    Function which verifies existence of _item and _unit, returns false in case
    of trouble, or when able to remove _item from _unit true in case of success.

Parameters:
    _unit - the unit <OBJECT>
    _item - name of the item to remove <STRING>

Returns:
    true on success, false otherwise <BOOLEAN>

Examples:
    (begin example)
        _result = [player, "FirstAidKit"] call CBA_fnc_removeItem
    (end)

Author:

---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(removeItem);

params [["_unit", objNull, [objNull]], ["_item", "", [""]]];

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

if !(configName _config in itemsWithMagazines _unit) exitWith {
    TRACE_2("Item not available on Unit",_unit,_item);
    _return
};

_unit removeItem _item;
true
