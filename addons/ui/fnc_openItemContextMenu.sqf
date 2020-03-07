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

params ["_display", "_item", "_slot"];

// Read context menu options.
private _config = _item call CBA_fnc_getItemConfig;
private _superclass = configName (configHierarchy _config param [1, configNull]);

private _options = [];
while {
    _options pushBack (GVAR(ContextMenuOptions) getVariable configName _config);
    _config = inheritsFrom _config;
    !isNull _config
} do {};

switch (toUpper _superclass) do {
    // magazines
    case "CFGMAGAZINES": {
        _options pushBack (GVAR(ContextMenuOptions) getVariable "AllMagazines");
    };

    // Other items, weapons
    case "CFGGLASSES";
    case "CFGWEAPONS": {
        _options pushBack (GVAR(ContextMenuOptions) getVariable "AllItems");
    };
};

_options pushBack (GVAR(ContextMenuOptions) getVariable "All");

// Skip menu if no options.
if (count _options isEqualTo 0) exitWith {};

private _list = _display ctrlCreate ["RscListBox", -1];
_list ctrlSetBackgroundColor [0.1,0.1,0.1,0.9]; //@todo

// Populate context menu with options. @todo
{
    _x params ["_slots", "_displayName", "_tooltip", "_condition", "_statement", "_params"];

    if ((_slot in _slots || {"ALL" in _slots}) && {[_params] call _condition}) then { // grey out instead?
        private _index = _list lbAdd _displayName;
        _list lbSetTooltip [_index, _tooltip];

        private _key = format [QGVAR(OptionData%1), _index];
        _list lbSetData [_index, _key];
        _list setVariable [_key, [_condition, _statement, _params]];
    };
} forEach _options;

// ---
// Execute context menu option statement on selection.
_list ctrlAddEventHandler ["lbDblClick", {
    params ["_list", "_index"];
    _list getVariable (_list lbData _index) params ["_condition", "_statement", "_params"];

    if (_params call _condition) then {
        // Call statement and safe check return value.
        private _keepOpen = [nil] apply {
            private ["_list", "_index"]; // Others are acceptable magic variables.
            _params call _statement // return
        } param [0, false] isEqualTo true;

        // If statement returned true, keep context menu open, otherwise close.
        if !(_keepOpen) then {
            [{ctrlDelete _this}, _list] call CBA_fnc_execNextFrame;
        };
    };
}];

// ---
// Set context menu position and size.
getMousePosition params ["_left", "_top"];

// Move slightly right and down to prevent accidental execution on triple click.
//_left = _left + pixelW;
//_top = _top + pixelH;

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
