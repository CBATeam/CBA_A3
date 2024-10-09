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

params ["_display", "_container", "_item", "_slot"];
if (_item isEqualTo "") exitWith {};

// ---
// Read context menu options.
private _config = _item call CBA_fnc_getItemConfig;

private _options = [];
while {
    _options append (GVAR(ItemContextMenuOptions) getVariable configName _config);
    _config = inheritsFrom _config;
    !isNull _config
} do {};

_item call BIS_fnc_itemType params ["_itemType1", "_itemType2"];
_options append (GVAR(ItemContextMenuOptions) getVariable [format ["##%1", _itemType2], []]);
_options append (GVAR(ItemContextMenuOptions) getVariable [format ["#%1", _itemType1], []]);
_options append (GVAR(ItemContextMenuOptions) getVariable ["#All", []]);

// Skip menu if no options.
if (_options isEqualTo []) exitWith {};

// ---
// Create context menu.
// ctrlSetBackgroundColor command does not seem to work for RscListBox.
private _list = _display ctrlCreate [QGVAR(ItemContextMenu), -1];

private _font = getText (configFile >> QGVAR(ItemContextMenu) >> "font");
private _fontSize = getNumber (configFile >> ctrlClassName _list >> "sizeEx");
private _longestName = "";

// ---
// Populate context menu with options.
{
    _x params ["_slots", "_displayName", "_tooltip", "_color", "_icon", "_conditionEnable", "_conditionShow", "_statement", "_consume", "_params"];

    //IGNORE_PRIVATE_WARNING ["_unit"]; // seems to come from upper scopes
    private _args = [_unit, _container, _item, _slot, _params];
    if (isLocalized _displayName) then {
        _displayName = localize _displayName;
    };

    if (isLocalized _tooltip) then {
        _tooltip = localize _tooltip;
    };

    if ((_slot in _slots || {"ALL" in _slots}) && {_args call _conditionShow}) then {
        if (count _longestName < count _displayName) then {
            _longestName = _displayName;
        };

        private _index = _list lbAdd _displayName;
        _list lbSetTooltip [_index, _tooltip]; // Does not seem to work for RscDisplayInventory controls? Hard coded overwrite?

        private _key = format [QGVAR(OptionData%1), _index];

        if (_color isEqualTo []) then {
            _color = getArray (configFile >> ctrlClassName _list >> "colorText");
        };

        _list lbSetColor [_index, _color];
        _list lbSetData [_index, _key];
        _list lbSetPicture [_index, _icon];

        // Due to the lack of suitable commands, items can not be consumed from the ground or cargo.
        if (_consume && {_slot in ["GROUND", "CARGO"]}) then {
            _conditionEnable = {false};
        };

        // Since this condition is negated, it should interpret nil return as "false" to avoid non-true return to not grey out.
        if !([_args call _conditionEnable] param [0, false]) then {
            // Gray out.
            _color = getArray (configFile >> ctrlClassName _list >> "colorDisabled");
            _list lbSetColor [_index, _color];
            _list lbSetSelectColor [_index, _color];

            // Keep open, but do nothing. Also don't consume.
            _conditionEnable = {true};
            _statement = {true};
            _consume = false;
        };

        _list setVariable [_key, [_conditionEnable, _statement, _consume, _args]];
    };
} forEach _options;

// ---
// Execute context menu option statement on selection.
_list setVariable [QFUNC(activate), {
    params ["_list", "_index"];
    _list getVariable (_list lbData _index) params ["_condition", "_statement", "_consume", "_this"];

    if (_this call _condition) then {
        if (_consume) then {
            params ["_unit", "_container", "_item", "_slot"];

            if !([_unit, _item, _slot, _container] call CBA_fnc_consumeItem) then {
                ERROR_2("Cannot consume item %1 from %2.",_item,_slot);
                _statement = {true};
            };
        };

        // Call statement and safe check return value.
        private _keepOpen = [nil] apply {
            private _this = [_this, _statement];
            private ["_list", "_index", "_condition", "_statement", "_consume"];
            (_this select 0) call (_this select 1) // return
        } param [0, false] isEqualTo true;

        // If statement returned true, keep context menu open, otherwise close.
        if (_keepOpen) then {
            // Keep focus to prevent auto closing.
            ctrlSetFocus _list;
        } else {
            [{ctrlDelete _this}, _list] call CBA_fnc_execNextFrame;
        };
    };
}];

_list ctrlAddEventHandler ["LBSelChanged", {
    [{
        params ["_list"];
        _this call (_list getVariable QFUNC(activate));
    }, _this] call CBA_fnc_execNextFrame;
}];
_list ctrlAddEventHandler ["KeyDown", {
    params ["", "_key"];
    // keyboard's Up/Down events intercepted to prevent LBSelChanged event
    if !(_key in [DIK_UP, DIK_DOWN]) exitWith {};
    true
}];

// ---
// Set context menu position and size.
getMousePosition params ["_left", "_top"];

// Move slightly left and up.
_left = _left - pixelW;
_top = _top - pixelH;

private _width = (ctrlPosition _list select 2) max ((_longestName getTextWidth [_font, _fontSize]) + TEXT_MARGINS_WIDTH + RSCLISTBOX_PICTURE_WIDTH);
private _height = lbSize _list * _fontSize;

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
