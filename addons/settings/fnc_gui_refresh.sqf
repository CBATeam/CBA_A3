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

    private _enabled = [_x, _setting, _source] call FUNC(gui_retargetRow);

    private _value = GET_TEMP_NAMESPACE_VALUE(_setting,_source);
    private _wasEdited = false;

    if (isNil "_value") then {
        _value = [_setting, _source] call FUNC(get);
    } else {
        _wasEdited = true;
    };

    [_x, _value] call (_x getVariable QFUNC(updateUI));

    private _priority = GET_TEMP_NAMESPACE_PRIORITY(_setting,_source);

    if (isNil "_priority") then {
        _priority = [_setting, _source] call FUNC(priority);
    } else {
        _wasEdited = true;
    };

    [_x, _priority] call (_x getVariable QFUNC(updateUI_priority));

    // the row is shared by the sources, so this has to be set back as well as set
    if (_enabled) then {
        private _ctrlSettingName = _x controlsGroupCtrl IDC_SETTING_NAME;
        _ctrlSettingName ctrlSetTextColor ([COLOR_TEXT_ENABLED, COLOR_TEXT_ENABLED_WAS_EDITED] select _wasEdited);
    };
} forEach (_ctrlOptionsGroup getVariable [QGVAR(rows), []]);
