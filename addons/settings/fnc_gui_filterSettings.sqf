#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_gui_filterSettings

Description:
    Hides the settings of the currently shown category that don't match the search
    bar and moves the remaining ones up to close the gaps.

    Has to run again whenever a different category or source is shown, because
    every combination of the two has its own set of controls.

Parameters:
    _display - Addon Options dialog <DISPLAY>

Returns:
    None

Examples:
    (begin example)
        [_display] call CBA_settings_fnc_gui_filterSettings;
    (end)

Author:
    LinkIsGrim
---------------------------------------------------------------------------- */

params ["_display"];

private _category = uiNamespace getVariable [QGVAR(addon), ""];
private _source = uiNamespace getVariable [QGVAR(source), ""];

if (_category isEqualTo "" || {_source isEqualTo ""}) exitWith {};

private _list = [QGVAR(list), _category, _source] joinString "$";
private _ctrlOptionsGroup = _display getVariable [_list, controlNull];

// category hasn't been created yet, it is filtered when it is
if (isNull _ctrlOptionsGroup) exitWith {};

private _rowOrder = _ctrlOptionsGroup getVariable [QGVAR(rowOrder), []];

// ----- show settings that match the search, hide the rest
private _isFiltered = (_display getVariable [QGVAR(searchText), ""]) isNotEqualTo "";
private _matches = createHashMapFromArray (((_display getVariable [QGVAR(searchMatches), createHashMap]) getOrDefault [_category, []]) apply {[_x, true]});

private _shownSettings = [];

{
    // sub-category headers only have members, they are hidden below once those are known
    if (isNil {_x getVariable QGVAR(members)}) then {
        private _show = !_isFiltered || {_matches getOrDefault [_x getVariable QGVAR(setting), false]};

        _x ctrlShow _show;

        if (_show) then {
            _shownSettings pushBack _x;
        };
    };
} forEach _rowOrder;

// ----- nothing moved, don't reposition every control for no reason
if (_shownSettings isEqualTo (_ctrlOptionsGroup getVariable [QGVAR(shownSettings), false])) exitWith {};

_ctrlOptionsGroup setVariable [QGVAR(shownSettings), _shownSettings];

// ----- move the remaining settings up to close the gaps
private _tablePosY = TABLE_LINE_SPACING/2;

{
    private _members = _x getVariable QGVAR(members);

    if (!isNil "_members") then {
        // hide sub-category headers that have no settings left
        private _show = (_members findIf {ctrlShown _x}) != -1;

        _x ctrlShow _show;

        if (_show) then {
            _tablePosY = [_x, _tablePosY] call FUNC(gui_setTablePosY);
        } else {
            [_x, 0, 0] call FUNC(gui_setTablePosY);
        };
    } else {
        (_x getVariable [QGVAR(spacer), [controlNull, 0]]) params ["_ctrlEmpty", "_spacerHeight"];

        if (ctrlShown _x) then {
            _tablePosY = [_x, _tablePosY] call FUNC(gui_setTablePosY);

            // padding doesn't take up space in the table, it only extends the scroll area
            if (!isNull _ctrlEmpty) then {
                _ctrlEmpty ctrlShow true;
                [_ctrlEmpty, _tablePosY, _spacerHeight] call FUNC(gui_setTablePosY);
            };
        } else {
            [_x, 0, 0] call FUNC(gui_setTablePosY);

            if (!isNull _ctrlEmpty) then {
                _ctrlEmpty ctrlShow false;
                [_ctrlEmpty, 0, 0] call FUNC(gui_setTablePosY);
            };
        };
    };
} forEach _rowOrder;

// ----- recalculate the scroll area and scroll back to the top
_ctrlOptionsGroup ctrlSetPosition (ctrlPosition _ctrlOptionsGroup);
_ctrlOptionsGroup ctrlCommit 0;
_ctrlOptionsGroup ctrlSetScrollValues [0, 0];
