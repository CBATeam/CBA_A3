#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_gui_toggleSubCategory

Description:
    Folds the settings of a sub-category away, or brings them back.

    A folded sub-category stays folded while a search is running, unless one of
    its settings matches, in which case it is opened so the match can be seen.

Parameters:
    _ctrlHeaderGroup - Sub-category header controls group <CONTROL>

Returns:
    None

Examples:
    (begin example)
        [_ctrlHeaderGroup] call CBA_settings_fnc_gui_toggleSubCategory;
    (end)

Author:
    LinkIsGrim
---------------------------------------------------------------------------- */

params ["_ctrlHeaderGroup"];

private _collapsed = !(_ctrlHeaderGroup getVariable [QGVAR(collapsed), false]);
_ctrlHeaderGroup setVariable [QGVAR(collapsed), _collapsed];

private _display = ctrlParent _ctrlHeaderGroup;

// remember it for the rest of the session, categories are rebuilt when the menu
// is opened again
private _collapsedGroups = uiNamespace getVariable [QGVAR(collapsedSubCategories), createHashMap];
_collapsedGroups set [_ctrlHeaderGroup getVariable QGVAR(foldKey), _collapsed];
uiNamespace setVariable [QGVAR(collapsedSubCategories), _collapsedGroups];

[_display, false] call FUNC(gui_filterSettings);
