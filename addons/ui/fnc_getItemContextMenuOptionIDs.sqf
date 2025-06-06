#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getItemContextMenuOptionIDs

Description:
    Returns Array of Item Context Menu IDs based on the item.
    If "" is provided, it will return nested array of all currently stored items.

Parameters:
    _item                   - Item classname <STRING>
                              Can be base class.

                              Can be item type as reported by BIS_fnc_itemType:
                                ["Equipment","Headgear"]
                                ->
                                "#Equipment" and/or "##Headgear"

                              Wildcard:
                                #All
                              (optional, default: "")

Returns:
    Nested Array [item, [IDs]] <ARRAY>

Examples:
    (begin example)
        [""] call CBA_fnc_getItemContextMenuOptionIDs;
    (end)

Author:
    Zorn
---------------------------------------------------------------------------- */

params [ ["_item", "", [""]] ];

// Force unscheduled environment to prevent race conditions.
if (canSuspend) exitWith {
    [CBA_fnc_getItemContextMenuOptionIDs, _this] call CBA_fnc_directCall;
};

if (!hasInterface) exitWith { [] };

if (isNil QGVAR(ItemContextMenuOptions)) exitWith { [] };


private _catalog = GVAR(ItemContextMenuOptions);

private _items = keys _catalog;


private _return = [];
if (_item == "") then {
    { _return append (_x call CBA_fnc_getItemContextMenuOptionIDs) } forEach _items;
} else {
    if !(_item in _items) exitWith { [] };
    _return pushBack [ _item, keys (_catalog get _item) ] 
};

_return
