#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_gui_fillAddonList

Description:
    Fills the addon list of the Addon Options menu, optionally with a subset of
    all categories.

    Does not restore the selection, the caller has to do that. Every entry stores
    its lower case category in its list data, which survives sorting and deleting.

Parameters:
    _ctrlAddonList - Addon list control <CONTROL>
    _categories    - Lower case categories to add, all if empty <ARRAY> (default: [])

Returns:
    None

Examples:
    (begin example)
        [_ctrlAddonList, ["cba_ui"]] call CBA_settings_fnc_gui_fillAddonList;
    (end)

Author:
    commy2, LinkIsGrim
---------------------------------------------------------------------------- */

params ["_ctrlAddonList", ["_categories", []]];

call FUNC(gui_index);

// deleting the selected entry fires LBSelChanged, which would create a category we're about to filter out
LOCK;

for "_index" from (lbSize _ctrlAddonList) - 1 to 0 step -1 do {
    _ctrlAddonList lbDelete _index;
};

{
    if (_categories isEqualTo [] || {_x in _categories}) then {
        private _index = _ctrlAddonList lbAdd (_y select 0);
        _ctrlAddonList lbSetData [_index, _x];
    };
} forEach GVAR(categorySettings);

lbSort _ctrlAddonList;

UNLOCK;
