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
#include "script_component.hpp"

private _display = uiNamespace getVariable [QGVAR(display), displayNull];
private _controls = allControls _display select {ctrlIDC _x isEqualTo IDC_SETTING_CONTROLS_GROUP};

{
    private _setting = _x getVariable QGVAR(setting);
    private _source = _x getVariable QGVAR(source);

    private _value = GET_TEMP_NAMESPACE_VALUE(_setting,_source);

    if (isNil "_value") then {
        _value = [_setting, _source] call FUNC(get);
    };

    [_x, _value] call (_x getVariable QFUNC(updateUI));

    private _priority = GET_TEMP_NAMESPACE_PRIORITY(_setting,_source);

    if (isNil "_priority") then {
        _priority = [_setting, _source] call FUNC(priority);
    };

    [_x, _priority] call (_x getVariable QFUNC(updateUI_priority));
} forEach _controls;
