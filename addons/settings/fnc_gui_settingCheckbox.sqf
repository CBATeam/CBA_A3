#include "script_component.hpp"

params ["_controlsGroup", "_setting", "_source", "_currentValue", "_settingData"];

private _ctrlCheckbox = _controlsGroup controlsGroupCtrl IDC_SETTING_CHECKBOX;
_ctrlCheckbox cbSetChecked _currentValue;

_ctrlCheckbox setVariable [QGVAR(params), [_setting, _source]];
_ctrlCheckbox ctrlAddEventHandler ["CheckedChanged", {
    params ["_ctrlCheckbox", "_state"];
    (_ctrlCheckbox getVariable QGVAR(params)) params ["_setting", "_source"];

    private _value = _state == 1;
    SET_TEMP_NAMESPACE_VALUE(_setting,_value,_source);

    // if new value is same as default value, grey out the default button
    private _controlsGroup = ctrlParentControlsGroup _ctrlCheckbox;
    private _ctrlDefault = _controlsGroup controlsGroupCtrl IDC_SETTING_DEFAULT;
    private _defaultValue = [_setting, "default"] call FUNC(get);
    _ctrlDefault ctrlEnable !(_value isEqualTo _defaultValue);
}];

// set setting ui manually to new value
_controlsGroup setVariable [QFUNC(updateUI), {
    params ["_controlsGroup", "_value"];

    private _ctrlCheckbox = _controlsGroup controlsGroupCtrl IDC_SETTING_CHECKBOX;
    _ctrlCheckbox cbSetChecked _value;

    // if new value is same as default value, grey out the default button
    private _ctrlDefault = _controlsGroup controlsGroupCtrl IDC_SETTING_DEFAULT;
    private _defaultValue = [_setting, "default"] call FUNC(get);
    _ctrlDefault ctrlEnable !(_value isEqualTo _defaultValue);
}];
