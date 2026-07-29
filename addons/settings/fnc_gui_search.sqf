#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_gui_search

Description:
    Applies the search bar of the Addon Options menu. Filters the addon list down
    to the categories that have a matching setting and hides the settings of the
    shown category that don't match.

    Matches display names, setting names, tooltips, categories, sub-categories and
    list labels. Spaces separate the search into parts that have to appear in that
    order, so "sum trauma" finds "Sum of Trauma".

Parameters:
    _display - Addon Options dialog <DISPLAY>

Returns:
    None

Examples:
    (begin example)
        [_display] call CBA_settings_fnc_gui_search;
    (end)

Author:
    LinkIsGrim
---------------------------------------------------------------------------- */

params ["_display"];

private _ctrlAddonList = _display displayCtrl IDC_ADDONS_LIST;
private _searchText = ctrlText (_display displayCtrl IDC_SEARCH_EDIT);

// searching for the same thing twice would just rebuild the same list
if (_searchText isEqualTo (_display getVariable [QGVAR(searchText), ""])) exitWith {};

private _selectedCategory = uiNamespace getVariable [QGVAR(addon), ""];
private _lastSearchText = _display getVariable [QGVAR(searchText), ""];

private _searchParts = (_searchText splitString " ") select {_x isNotEqualTo ""};

// ----- nothing to search for, show everything again
if (_searchParts isEqualTo []) exitWith {
    _display setVariable [QGVAR(searchText), ""];
    _display setVariable [QGVAR(searchMatches), createHashMap];

    [_ctrlAddonList] call FUNC(gui_fillAddonList);
    [_display, _ctrlAddonList, _selectedCategory] call FUNC(gui_searchSelect);
};

private _searchPattern = ".*?" + ((_searchParts apply {_x call CBA_fnc_escapeRegex}) joinString ".*?") + ".*?/io";

call FUNC(gui_searchIndex);

// ----- adding to the search can only ever remove results, so only search through those again
private _searchScope = createHashMap;

if (_lastSearchText isNotEqualTo "" && {(_searchText find _lastSearchText) == 0}) then {
    _searchScope = _display getVariable [QGVAR(searchMatches), createHashMap];
} else {
    {
        _searchScope set [_x, _y select 1];
    } forEach GVAR(searchCategories);
};

private _searchMatches = createHashMap;
private _categories = [];

{
    private _matches = _y select {(GVAR(searchIndex) get _x) regexMatch _searchPattern};

    if (_matches isNotEqualTo []) then {
        _searchMatches set [_x, _matches];
        _categories pushBack _x;
    };
} forEach _searchScope;

_display setVariable [QGVAR(searchText), _searchText];
_display setVariable [QGVAR(searchMatches), _searchMatches];

[_ctrlAddonList, _categories] call FUNC(gui_fillAddonList);
[_display, _ctrlAddonList, _selectedCategory] call FUNC(gui_searchSelect);
