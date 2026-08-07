#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_gui_reflow

Description:
    Lays out the settings table of one category. Hidden settings are collapsed to
    nothing so they leave no gap, and sub-category headers with nothing left below
    them are hidden.

    This is the only place settings are positioned. They are created without a
    position and laid out here once, after it is known which of them are shown.

Parameters:
    _ctrlOptionsGroup - Options controls group of a category <CONTROL>
    _resetScroll      - Scroll back to the top afterwards <BOOL> (default: false)

Returns:
    None

Examples:
    (begin example)
        _ctrlOptionsGroup call CBA_settings_fnc_gui_reflow;
    (end)

Author:
    LinkIsGrim
---------------------------------------------------------------------------- */

params ["_ctrlOptionsGroup", ["_resetScroll", false]];

private _tablePosY = TABLE_LINE_SPACING/2;

// an open dropdown is drawn below its setting, so the scroll area has to reach
// past the lowest one of them
private _scrollPosY = 0;

private _stripe = false;

{
    private _ctrlRow = _x;
    private _members = _ctrlRow getVariable QGVAR(members);

    if (!isNil "_members") then {
        // ----- hide sub-category headers the search left nothing in. A folded one
        // ----- stays, it is the only way to unfold it again.
        private _show = (_members findIf {_x getVariable [QGVAR(matched), true]}) != -1;

        _ctrlRow ctrlShow _show;

        if (_show) then {
            private _collapsed = _ctrlRow getVariable [QGVAR(collapsed), false];

            (_ctrlRow controlsGroupCtrl IDC_SETTING_NAME) ctrlSetText format [
                "%1 %2:",
                [SUBCAT_OPEN, SUBCAT_CLOSED] select _collapsed,
                _ctrlRow getVariable [QGVAR(subCategory), ""]
            ];

            _tablePosY = [_ctrlRow, _tablePosY] call FUNC(gui_setTablePosY);

            // every group bands the same way, so folding one doesn't invert the next
            _stripe = false;
        } else {
            [_ctrlRow, 0, 0] call FUNC(gui_setTablePosY);
        };
    } else {
        if (ctrlShown _x) then {
            // every row class declares Background itself, an inherited child that
            // is never redeclared doesn't get created and this would find nothing
            (_x controlsGroupCtrl IDC_SETTING_BACKGROUND) ctrlSetBackgroundColor ([COLOR_ROW, COLOR_ROW_ALT] select _stripe);

            _stripe = !_stripe;

            _tablePosY = [_x, _tablePosY] call FUNC(gui_setTablePosY);
            _scrollPosY = _scrollPosY max (_tablePosY + (_x getVariable [QGVAR(dropdownHeight), 0]));
        } else {
            [_x, 0, 0] call FUNC(gui_setTablePosY);
        };
    };
} forEach (_ctrlOptionsGroup getVariable [QGVAR(rowOrder), []]);

// ----- one pad below the table keeps the scroll area tall enough for dropdowns
private _ctrlPad = _ctrlOptionsGroup getVariable [QGVAR(pad), controlNull];

if (!isNull _ctrlPad) then {
    [_ctrlPad, _tablePosY, (_scrollPosY - _tablePosY) max 0] call FUNC(gui_setTablePosY);
};

// ----- there is no command to recalculate the scroll area, but setting the group's
// ----- own position again makes the engine measure it from its children
_ctrlOptionsGroup ctrlSetPosition (ctrlPosition _ctrlOptionsGroup);
_ctrlOptionsGroup ctrlCommit 0;

// ----- this only moves the scroll bar, it does not size the scroll area. Folding
// ----- a sub-category away shouldn't throw the reader back to the top.
if (_resetScroll) then {
    _ctrlOptionsGroup ctrlSetScrollValues [0, 0];
};
