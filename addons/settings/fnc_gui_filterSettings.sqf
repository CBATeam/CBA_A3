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

if (_category isEqualTo "") exitWith {};

private _ctrlOptionsGroup = (_display getVariable [QGVAR(optionsGroups), createHashMap]) getOrDefault [_category, controlNull];

// category hasn't been created yet, it is filtered when it is
if (isNull _ctrlOptionsGroup) exitWith {};

// ----- show settings that match the search, hide the rest
private _isFiltered = (_display getVariable [QGVAR(searchText), ""]) isNotEqualTo "";
private _matches = createHashMapFromArray (((_display getVariable [QGVAR(searchMatches), createHashMap]) getOrDefault [_category, []]) apply {[_x, true]});

private _shownRows = [];

{
    private _show = !_isFiltered || {_matches getOrDefault [_x getVariable QGVAR(setting), false]};

    _x ctrlShow _show;

    if (_show) then {
        _shownRows pushBack _x;
    };
} forEach (_ctrlOptionsGroup getVariable [QGVAR(rows), []]);

// ----- nothing moved, don't reposition every control for no reason
if (_shownRows isEqualTo (_ctrlOptionsGroup getVariable [QGVAR(shownRows), false])) exitWith {};

_ctrlOptionsGroup setVariable [QGVAR(shownRows), _shownRows];

_ctrlOptionsGroup call FUNC(gui_reflow);
