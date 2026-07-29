#include "script_component.hpp"

params ["_controlsGroup", "_setting", "_source", "_currentValue", "_settingData"];

private _ctrlCheckbox = _controlsGroup controlsGroupCtrl IDC_SETTING_CHECKBOX;
_ctrlCheckbox cbSetChecked _currentValue;

_ctrlCheckbox ctrlAddEventHandler ["CheckedChanged", {
    params ["_ctrlCheckbox", "_state"];

    private _controlsGroup = ctrlParentControlsGroup _ctrlCheckbox;
    private _setting = ROW_SETTING(_controlsGroup);
    private _source = ROW_SOURCE(_controlsGroup);

    private _value = _state == 1;
    SET_TEMP_NAMESPACE_VALUE(_setting,_value,_source);

    // if new value is same as default value, grey out the default button
    private _defaultValue = [_setting, "default"] call FUNC(get);
    ROW_ENABLE(_controlsGroup,IDC_SETTING_DEFAULT,_value isNotEqualTo _defaultValue);

    // automatically check "overwrite client" for mission makers qol
    [_controlsGroup, _source] call (_controlsGroup getVariable QFUNC(auto_check_overwrite));
    // refresh priority to update overwrite color if current value is equal to overwrite
    [_controlsGroup] call (_controlsGroup getVariable QFUNC(updateUI_locked));
}];

// set setting ui manually to new value
_controlsGroup setVariable [QFUNC(updateUI), {
    params ["_controlsGroup", "_value"];

    private _setting = ROW_SETTING(_controlsGroup);

    private _ctrlCheckbox = _controlsGroup controlsGroupCtrl IDC_SETTING_CHECKBOX;
    _ctrlCheckbox cbSetChecked _value;

    // if new value is same as default value, grey out the default button
    private _defaultValue = [_setting, "default"] call FUNC(get);
    ROW_ENABLE(_controlsGroup,IDC_SETTING_DEFAULT,_value isNotEqualTo _defaultValue);
}];
