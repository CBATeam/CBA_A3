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
private _tooltips = [];

// ---
// Populate context menu with options.
{
    _x params ["_slots", "_displayName", "_tooltip", "_color", "_icon", "_conditionEnable", "_conditionShow", "_statement", "_consume", "_params"];

    private _args = [_unit, _container, _item, _slot, _params];
    if (isLocalized _displayName) then {
        _displayName = localize _displayName;
    };

    if (isLocalized _tooltip) then {
        _tooltip = localize _tooltip;
    };

    if ((_slot in _slots || {"ALL" in _slots}) && {_args call _conditionShow}) then {
        private _index = _list lbAdd _displayName;
        _list lbSetTooltip [_index, "_tooltip"]; // Does not seem to work for RscDisplayInventory controls? Hard coded overwrite?
        _tooltips pushBack _tooltip;

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
// Save tooltip text (workaround until https://community.bistudio.com/wiki/lbTooltip released)
_list setVariable [QGVAR(TooltipsData), _tooltips];

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
            [{
                ctrlDelete (_this getVariable [QGVAR(MenuTooltip), controlNull]);
                ctrlDelete _this
            }, _list] call CBA_fnc_execNextFrame;
        };
    };
}];

_list ctrlAddEventHandler ["lbDblClick", {
    params ["_list"];
    _this call (_list getVariable QFUNC(activate));
}];

_list ctrlAddEventHandler ["KeyDown", {
    params ["_list", "_key"];
    if (_key in [DIK_RETURN, DIK_NUMPADENTER]) then {
        [_list getVariable QFUNC(activate), [_list, lbCurSel _list]] call CBA_fnc_execNextFrame;

        // Set focus on background to prevent the inventory menu from auto closing.
        ctrlSetFocus (ctrlParent _list displayCtrl IDC_FG_GROUND_TAB);
    };
}];

// ---
// Set context menu position and size.
getMousePosition params ["_left", "_top"];

// Move slightly left and up.
_left = _left - pixelW;
_top = _top - pixelH;

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

        private _tooltip = _list getVariable [QGVAR(MenuTooltip), controlNull];
        if (focusedCtrl (ctrlParent _list) isEqualto _tooltip) exitWith {};

        if (diag_frameNo > _list getVariable [QGVAR(FocusFrame), 0]) then {
            ctrlDelete _tooltip;
            ctrlDelete _list;
        };
    }, _this] call CBA_fnc_execNextFrame;
}];


// ---
// Handle context menu's tooltip
_list ctrlAddEventHandler ["MouseMoving", {
    params ["_list", "_xPos", "_yPos", "_mouseOver"];

    private _tooltip = _list getVariable [QGVAR(MenuTooltip), nil];

    // --- When mouse moved out of menu - delete tooltip and switch focus back to menu
    if (!_mouseOver) exitWith {
        ctrlDelete _tooltip;
        _list setVariable [QGVAR(MenuTooltip), nil];
        ctrlSetFocus _list;
    };

    // --- Create tooltip if none
    if (isNil "_tooltip") then {
        // Creates a listbox as we need something focusable to make tooltip overlay menu
        _tooltip = ctrlParent _list ctrlCreate [QGVAR(ItemContextMenu_Tooltip), -1];

        _list setVariable [QGVAR(MenuTooltip), _tooltip];
        _tooltip lbAdd "";

        _tooltip setVariable ["FontsInfo", [
            getText (configFile >> "RscListBox" >> "font"),
            getNumber (configFile >> ctrlClassName _tooltip >> "sizeEx"),
            getNumber (configFile >> ctrlClassName _list >> "sizeEx")
        ]];

        // Intercepts keyboard interactions with list
        _tooltip ctrlAddEventHandler ["KeyDown", {
            params ["", "_key"];
            if !(_key in [DIK_UP, DIK_DOWN]) exitWith {};
            true
        }];
    };

    (_tooltip getVariable "FontsInfo") params ["_font","_fontSize","_listFontSize"];

    // --- Calculating index of list item under the mouse cursor
    private _listHeight = _yPos - (ctrlPosition _list select 1);
    private _listIndex = floor (_listHeight / _listFontSize);
    private _text = (_list getVariable QGVAR(TooltipsData)) # _listIndex;

    _tooltip lbSetText [0, _text];

    _xPos = _xPos + 15 * pixelW;
    _yPos = _yPos + 15 * pixelH;
    private _w = 1.1 * (_text getTextWidth [_font, _fontSize]);
    private _h = 1.1 * _fontSize;

    _tooltip ctrlSetPosition [_xPos, _yPos, _w, _h];
    _tooltip ctrlCommit 0;
    ctrlSetFocus _tooltip;
}];
