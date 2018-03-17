#include "script_component.hpp"

params ["_controlsGroup", "_setting", "_source", "_currentValue", "_settingData"];
_settingData params ["_min", "_max", "_trailingDecimals"];

private _ctrlSlider = _controlsGroup controlsGroupCtrl IDC_SETTING_SLIDER;

_ctrlSlider sliderSetRange [_min, _max];
_ctrlSlider sliderSetPosition _currentValue;

_ctrlSlider setVariable [QGVAR(params), [_setting, _source, _trailingDecimals]];
_ctrlSlider ctrlAddEventHandler ["SliderPosChanged", {
    params ["_ctrlSlider", "_value"];
    (_ctrlSlider getVariable QGVAR(params)) params ["_setting", "_source", "_trailingDecimals"];

    if (_trailingDecimals < 0) then {
        _value = round _value;
    };

    private _controlsGroup = ctrlParentControlsGroup _ctrlSlider;
    private _ctrlSliderEdit = _controlsGroup controlsGroupCtrl IDC_SETTING_SLIDER_EDIT;
    _ctrlSliderEdit ctrlSetText ([_value, 1, _trailingDecimals max 0] call CBA_fnc_formatNumber);

    SET_TEMP_NAMESPACE_VALUE(_setting,_value,_source);

    // if new value is same as default value, grey out the default button
    private _ctrlDefault = _controlsGroup controlsGroupCtrl IDC_SETTING_DEFAULT;
    private _defaultValue = [_setting, "default"] call FUNC(get);
    _ctrlDefault ctrlEnable !(_value isEqualTo _defaultValue);

    // automatically check "overwrite client" for mission makers qol
    [_controlsGroup, _source] call (_controlsGroup getVariable QFUNC(auto_check_overwrite));
}];

private _ctrlSliderEdit = _controlsGroup controlsGroupCtrl IDC_SETTING_SLIDER_EDIT;
_ctrlSliderEdit ctrlSetText ([_currentValue, 1, _trailingDecimals max 0] call CBA_fnc_formatNumber);

_ctrlSliderEdit setVariable [QGVAR(params), [_setting, _source, _trailingDecimals]];
_ctrlSliderEdit ctrlAddEventHandler ["KeyUp", {
    params ["_ctrlSliderEdit"];
    (_ctrlSliderEdit getVariable QGVAR(params)) params ["_setting", "_source", "_trailingDecimals"];

    private _value = parseNumber ctrlText _ctrlSliderEdit;

    if (_trailingDecimals < 0) then {
        _value = round _value;
    };

    private _controlsGroup = ctrlParentControlsGroup _ctrlSliderEdit;
    private _ctrlSlider = _controlsGroup controlsGroupCtrl IDC_SETTING_SLIDER;

    _ctrlSlider sliderSetPosition _value;
    _value = sliderPosition _ctrlSlider;

    SET_TEMP_NAMESPACE_VALUE(_setting,_value,_source);

    // if new value is same as default value, grey out the default button
    private _ctrlDefault = _controlsGroup controlsGroupCtrl IDC_SETTING_DEFAULT;
    private _defaultValue = [_setting, "default"] call FUNC(get);
    _ctrlDefault ctrlEnable !(_value isEqualTo _defaultValue);

    // automatically check "overwrite client" for mission makers qol
    [_controlsGroup, _source] call (_controlsGroup getVariable QFUNC(auto_check_overwrite));
}];

_ctrlSliderEdit ctrlAddEventHandler ["KillFocus", {
    params ["_ctrlSliderEdit"];
    (_ctrlSliderEdit getVariable QGVAR(params)) params ["_setting", "_source", "_trailingDecimals"];

    private _controlsGroup = ctrlParentControlsGroup _ctrlSliderEdit;
    private _ctrlSlider = _controlsGroup controlsGroupCtrl IDC_SETTING_SLIDER;

    private _value = sliderPosition _ctrlSlider;

    if (_trailingDecimals < 0) then {
        _value = round _value;
    };

    _ctrlSliderEdit ctrlSetText ([_value, 1, _trailingDecimals max 0] call CBA_fnc_formatNumber);

    // if new value is same as default value, grey out the default button
    private _ctrlDefault = _controlsGroup controlsGroupCtrl IDC_SETTING_DEFAULT;
    private _defaultValue = [_setting, "default"] call FUNC(get);
    _ctrlDefault ctrlEnable !(_value isEqualTo _defaultValue);
}];

// set setting ui manually to new value
_controlsGroup setVariable [QFUNC(updateUI), {
    params ["_controlsGroup", "_value"];
    (_controlsGroup getVariable QGVAR(params)) params ["_min", "_max", "_trailingDecimals"];

    private _ctrlSlider = _controlsGroup controlsGroupCtrl IDC_SETTING_SLIDER;
    private _ctrlSliderEdit = _controlsGroup controlsGroupCtrl IDC_SETTING_SLIDER_EDIT;

    _ctrlSlider sliderSetPosition _value;
    _ctrlSliderEdit ctrlSetText ([_value, 1, _trailingDecimals max 0] call CBA_fnc_formatNumber);

    // if new value is same as default value, grey out the default button
    private _ctrlDefault = _controlsGroup controlsGroupCtrl IDC_SETTING_DEFAULT;
    private _defaultValue = [_setting, "default"] call FUNC(get);
    _ctrlDefault ctrlEnable !(_value isEqualTo _defaultValue);
}];
