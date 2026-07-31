#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_gui_refresh

Description:
    Points the rows of the shown category at the shown source and resets them to
    their current (temporary) value.

    Only the shown category is kept up to date. The others are refreshed when
    they are selected, which is also when they are created.

Parameters:
    None

Returns:
    None

Author:
    commy2, LinkIsGrim
---------------------------------------------------------------------------- */

private _display = uiNamespace getVariable [QGVAR(display), displayNull];

private _category = uiNamespace getVariable [QGVAR(addon), ""];
private _source = uiNamespace getVariable [QGVAR(source), ""];

// no category is shown before the menu is switched to the addon options
if (_category isEqualTo "" || {_source isEqualTo ""}) exitWith {};

private _ctrlOptionsGroup = (_display getVariable [QGVAR(optionsGroups), createHashMap]) getOrDefault [_category, controlNull];

if (isNull _ctrlOptionsGroup) exitWith {};

{
    private _setting = ROW_SETTING(_x);

    [_x, _setting, _source] call FUNC(gui_retargetRow);

    [_x, GET_TEMP_NAMESPACE_VALUE_OR_CURRENT(_setting,_source)] call (_x getVariable QFUNC(updateUI));
    [_x, GET_TEMP_NAMESPACE_PRIORITY_OR_CURRENT(_setting,_source)] call (_x getVariable QFUNC(updateUI_priority));

    // the row is shared by the sources, so this has to be set back as well as set
    _x call FUNC(gui_setRowEdited);
} forEach (_ctrlOptionsGroup getVariable [QGVAR(rows), []]);
