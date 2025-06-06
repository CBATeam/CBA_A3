#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeItemContextMenuOption

Description:
    Removes context menu option.

Parameters:
    _item                   - Item classname <STRING>
                              Can be base class.

                              Can be item type as reported by BIS_fnc_itemType:
                                ["Equipment","Headgear"]
                                ->
                                "#Equipment" and/or "##Headgear"

                              Wildcard:
                                #All

    _ident                  - ID of the option. Can be used to remove an option.
                              If none provided, generic ID will be generated.
                              An already existing ID will overwrite the previous settings.
                              (optional, default: "") <STRING>

Returns:
    Success <BOOL>.

Examples:
    (begin example)
        ["#All", "Tag_myOption_3"] call CBA_fnc_removeItemContextMenuOption;
    (end)

Author:
    Zorn
---------------------------------------------------------------------------- */

params [
    ["_item", "All", [""]],
    ["_ident", "", [""]]
];

// Force unscheduled environment to prevent race conditions.
if (canSuspend) exitWith {
    [CBA_fnc_removeItemContextMenuOption, _this] call CBA_fnc_directCall;
};

if (!hasInterface) exitWith {};

// Initialize system on first execution.
if (isNil QGVAR(ItemContextMenuOptions)) exitWith { false };

if !(_item in keys GVAR(ItemContextMenuOptions)) exitWith { false };
private _options = GVAR(ItemContextMenuOptions) get _item;

if !(_ident in keys _options) exitWith { false };

_options deleteAt _ident;

true
