#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_gui_refresh

Description:
    Resets all settings controls to their current (temporary) value.

Parameters:
    None

Returns:
    None

Author:
    commy2
---------------------------------------------------------------------------- */

private _display = uiNamespace getVariable [QGVAR(display), displayNull];
private _controls = allControls _display select {ctrlIDC _x isEqualTo IDC_SETTING_CONTROLS_GROUP};

{
    private _setting = _x getVariable QGVAR(setting);
    private _source = _x getVariable QGVAR(source);

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

    // change color if setting was edited
    if (_wasEdited) then {
        private _ctrlSettingName = _x controlsGroupCtrl IDC_SETTING_NAME;
        _ctrlSettingName ctrlSetTextColor COLOR_TEXT_ENABLED_WAS_EDITED;
    };
} forEach _controls;
