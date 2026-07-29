#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_gui_index

Description:
    Builds the indices the Addon Options menu is drawn and searched from, unless
    they already exist. FUNC(init) clears them whenever a setting is added or
    changed.

    GVAR(categorySettings) holds every category's settings in the order the menu
    shows them, so opening a category doesn't have to walk and sort every setting
    in the game. GVAR(subCategories) marks where each sub-category header goes.

    GVAR(searchIndex) joins every searchable field of a setting into one string,
    separated by newlines. A regex "." doesn't match a newline, so one match
    against that string covers all fields at once without matching across two of
    them. Matching every field separately on every keystroke is too slow.

Parameters:
    None

Returns:
    None

Examples:
    (begin example)
        call CBA_settings_fnc_gui_index;
    (end)

Author:
    LinkIsGrim
---------------------------------------------------------------------------- */

if (!isNil QGVAR(categorySettings)) exitWith {};

private _searchIndex = createHashMap;
private _categorySettings = createHashMap;
private _subCategories = createHashMap;

// lower case category -> [[hasSubCategory, subCategory, registration index, setting], ...]
private _sortable = createHashMap;

{
    (GVAR(default) getVariable _x) params ["", "_setting", "_settingType", "_settingData", "_category", "_displayName", "_tooltip", "", "", "_subCategory"];

    private _fields = [_displayName, _setting, _tooltip, _category, _subCategory];

    // list labels and their tooltips are searchable as well
    if (toUpper _settingType == "LIST") then {
        _fields append (_settingData param [1, []]);
        _fields append (_settingData param [2, []]);
    };

    _searchIndex set [_setting, _fields joinString NEWLINE];

    // the menu groups settings by lower case category, first spelling wins
    private _key = toLower _category;
    _categorySettings getOrDefault [_key, [_category, []], true];

    // Make sure empty-subcategory is always sorted first (fixing unicode)
    (_sortable getOrDefault [_key, [], true]) pushBack [parseNumber (_subCategory != ""), _subCategory, _forEachIndex, _setting];
} forEach GVAR(allSettings);

{
    private _key = _x;
    private _sorted = _y;

    _sorted sort true;

    private _settings = (_categorySettings get _key) select 1;

    // each run is [sub-category, index of its first setting]; settings without one
    // sort first and get no header
    private _runs = [];
    private _lastSubCategory = "";

    {
        _x params ["", "_subCategory", "", "_setting"];

        if (_subCategory isNotEqualTo "" && {_subCategory isNotEqualTo _lastSubCategory}) then {
            _runs pushBack [_subCategory, count _settings];
        };

        _lastSubCategory = _subCategory;
        _settings pushBack _setting;
    } forEach _sorted;

    _subCategories set [_key, _runs];
} forEach _sortable;

GVAR(searchIndex) = _searchIndex;
GVAR(categorySettings) = _categorySettings;
GVAR(subCategories) = _subCategories;
