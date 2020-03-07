#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: cba_ui_fnc_openItemContextMenu

Description:
    Opens the item context menu on the inventory screen.

Parameters:
    _display - RscDisplayInventory display <DISPLAY>
    _item    - Item classname <STRING>

Returns:
    Nothing/Undefined.

Examples:
    (begin example)
        call cba_ui_fnc_openItemContextMenu;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

params ["_display", "_item", "_containerType"]; systemChat str [_item, _containerType];

private _list = _display ctrlCreate ["RscListBox", -1];
_list ctrlSetBackgroundColor [0.1,0.1,0.1,0.9]; //@todo

// Testing
private _options = [
    ["Option 1", {true}, {systemChat str 1}],
    ["Option 2", {true}, {systemChat str 2}],
    ["Option 3", {true}, {systemChat str 3}],
    ["Option 4", {true}, {systemChat str 4}]
];

// Skip menu if no options.
if (count _options isEqualTo 0) exitWith {};

// Populate context menu with options. @todo
{
    _x params ["_displayName", "_condition", "_statement"];

    if (call _condition) then { // grey out instead?
        private _index = _list lbAdd _displayName;
        private _key = format [QGVAR(OptionData%1), _index];
        _list lbSetData [_index, _key];
        _list setVariable [_key, [_condition, _statement]];
    };
} forEach _options;

// ---
// Execute context menu option statement on selection.
_list ctrlAddEventHandler ["lbSelChanged", {
    params ["_list", "_index"];
    _list getVariable (_list lbData _index) params ["_condition", "_statement"];

    if (call _condition) then _statement;
    // If statement returns true: keep context menu open, otherwise close. @todo
}];

// ---
// Set context menu position and size.
getMousePosition params ["_left", "_top"];

// Move slightly right and down to prevent accidental execution on triple click.
_left = _left + pixelW;
_top = _top + pixelH;

private _width = ctrlPosition _list select 2;
private _height = lbSize _list * getNumber (configFile >> ctrlClassName _list >> "sizeEx");

_list ctrlSetPosition [_left, _top, _width, _height];
_list ctrlCommit 0;

// ---
// Handle context menu focus and auto close.
ctrlSetFocus _list;
_list ctrlAddEventHandler ["SetFocus", {
    params ["_list"];
    _list setVariable [QGVAR(FocusFrame), diag_frameNo + 1];
}];
_list ctrlAddEventHandler ["KillFocus", {
    [{
        params ["_list"];

        if (diag_frameNo > _list getVariable [QGVAR(FocusFrame), 0]) then {
            ctrlDelete _list;
        };
    }, _this] call CBA_fnc_execNextFrame;
}];
