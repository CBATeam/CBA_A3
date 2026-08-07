#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_gui_searchSelect

Description:
    Selects a category in the addon list again after the list was filtered. Falls
    back to the first remaining category if it was filtered out.

    Selecting an entry fires the LBSelChanged event, which would create the whole
    category. That is only wanted when the category actually changes, so the
    eventhandler is locked out otherwise.

Parameters:
    _display        - Addon Options dialog <DISPLAY>
    _ctrlAddonList  - Addon list control <CONTROL>
    _category       - Lower case category to select <STRING>

Returns:
    None

Examples:
    (begin example)
        [_display, _ctrlAddonList, "cba_ui"] call CBA_settings_fnc_gui_searchSelect;
    (end)

Author:
    LinkIsGrim
---------------------------------------------------------------------------- */

params ["_display", "_ctrlAddonList", "_category"];

private _index = -1;

for "_lbIndex" from 0 to (lbSize _ctrlAddonList) - 1 do {
    if (_ctrlAddonList lbData _lbIndex == _category) exitWith {
        _index = _lbIndex;
    };
};

// ----- nothing matches at all, keep the category so it comes back when the search is cleared
if (_index == -1 && {lbSize _ctrlAddonList == 0}) exitWith {
    [_display] call FUNC(gui_filterSettings);
};

// ----- the category is gone, show the first one that's left instead
if (_index == -1) exitWith {
    LOCK;
    _ctrlAddonList lbSetCurSel 0;
    UNLOCK;

    [_ctrlAddonList, 0] call FUNC(gui_addonChanged);
};

LOCK;
_ctrlAddonList lbSetCurSel _index;
UNLOCK;

[_display] call FUNC(gui_filterSettings);
