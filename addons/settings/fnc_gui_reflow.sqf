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

Returns:
    None

Examples:
    (begin example)
        _ctrlOptionsGroup call CBA_settings_fnc_gui_reflow;
    (end)

Author:
    LinkIsGrim
---------------------------------------------------------------------------- */

params ["_ctrlOptionsGroup"];

private _tablePosY = TABLE_LINE_SPACING/2;

// an open dropdown is drawn below its setting, so the scroll area has to reach
// past the lowest one of them
private _scrollPosY = 0;

{
    private _members = _x getVariable QGVAR(members);

    if (!isNil "_members") then {
        // ----- hide sub-category headers that have no settings left
        private _show = (_members findIf {ctrlShown _x}) != -1;

        _x ctrlShow _show;

        if (_show) then {
            _tablePosY = [_x, _tablePosY] call FUNC(gui_setTablePosY);
        } else {
            [_x, 0, 0] call FUNC(gui_setTablePosY);
        };
    } else {
        if (ctrlShown _x) then {
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

// ----- this only moves the scroll bar, it does not size the scroll area
_ctrlOptionsGroup ctrlSetScrollValues [0, 0];
