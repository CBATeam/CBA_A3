#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_gui_searchIndex

Description:
    Builds the search index used by the Addon Options menu search bar, unless it
    already exists.

    Matching every field of every setting on every keystroke is too slow, so the
    fields are joined up front and cached. FUNC(init) clears the cache whenever a
    setting is added or changed.

    Every searchable field of a setting is joined into a single string, separated
    by newlines. A regex "." doesn't match a newline, so one match against that
    string covers all fields at once without matching across two of them.

Parameters:
    None

Returns:
    None

Examples:
    (begin example)
        call CBA_settings_fnc_gui_searchIndex;
    (end)

Author:
    LinkIsGrim
---------------------------------------------------------------------------- */

if (!isNil QGVAR(searchIndex)) exitWith {};

private _searchIndex = createHashMap;
private _searchCategories = createHashMap;

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
    private _categorySettings = _searchCategories getOrDefault [toLower _category, [_category, []], true];
    (_categorySettings select 1) pushBack _setting;
} forEach GVAR(allSettings);

GVAR(searchIndex) = _searchIndex;
GVAR(searchCategories) = _searchCategories;
