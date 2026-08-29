#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_gui_filterSettings

Description:
    Hides the settings of the currently shown category that don't match the search
    bar and moves the remaining ones up to close the gaps.

    Has to run again whenever a different category or source is shown, because
    every combination of the two has its own set of controls.

Parameters:
    _display      - Addon Options dialog <DISPLAY>
    _resetScroll  - Scroll back to the top afterwards <BOOL> (default: true)

Returns:
    None

Examples:
    (begin example)
        [_display] call CBA_settings_fnc_gui_filterSettings;
    (end)

Author:
    LinkIsGrim
---------------------------------------------------------------------------- */

params ["_display", ["_resetScroll", true]];

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
    private _matched = !_isFiltered || {_matches getOrDefault [_x getVariable QGVAR(setting), false]};

    // a folded sub-category stays folded, unless the search found something in it
    private _ctrlHeaderGroup = _x getVariable [QGVAR(header), controlNull];
    private _folded = !isNull _ctrlHeaderGroup
        && {_ctrlHeaderGroup getVariable [QGVAR(collapsed), false]}
        && {!_isFiltered};

    private _show = _matched && !_folded;

    // a header is kept for as long as the search left it anything, folded or not
    _x setVariable [QGVAR(matched), _matched];

    // showing a row shows every control inside it, so the overwrite checkboxes
    // the source it is pointed at doesn't use have to be hidden again. Rows that
    // stay where they are keep theirs, this runs on every keystroke of the search.
    if (_show isNotEqualTo (ctrlShown _x)) then {
        _x ctrlShow _show;
        _x call FUNC(gui_setOverwriteVisible);
    };

    if (_show) then {
        _shownRows pushBack _x;
    };
} forEach (_ctrlOptionsGroup getVariable [QGVAR(rows), []]);

// ----- nothing moved, don't reposition every control for no reason
if (_shownRows isEqualTo (_ctrlOptionsGroup getVariable [QGVAR(shownRows), false])) exitWith {};

_ctrlOptionsGroup setVariable [QGVAR(shownRows), _shownRows];

[_ctrlOptionsGroup, _resetScroll] call FUNC(gui_reflow);
