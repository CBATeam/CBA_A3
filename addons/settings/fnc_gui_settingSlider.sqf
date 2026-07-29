#include "script_component.hpp"

params ["_controlsGroup", "_setting", "_source", "_currentValue", "_settingData"];
_settingData params ["_min", "_max", "_trailingDecimals", "_isPercentage"];

private _range = _max - _min;

private _ctrlSlider = _controlsGroup controlsGroupCtrl IDC_SETTING_SLIDER;
_ctrlSlider sliderSetRange [_min, _max];
_ctrlSlider sliderSetPosition _currentValue;
_ctrlSlider sliderSetSpeed [0.05 * _range, 0.1 * _range];

_ctrlSlider ctrlAddEventHandler ["SliderPosChanged", {
    params ["_ctrlSlider", "_value"];

    private _controlsGroup = ctrlParentControlsGroup _ctrlSlider;
    private _setting = ROW_SETTING(_controlsGroup);
    private _source = ROW_SOURCE(_controlsGroup);
    (_controlsGroup getVariable QGVAR(settingData)) params ["", "", "_trailingDecimals", "_isPercentage"];

    private _editText = if (_isPercentage) then {
        format [localize "STR_3DEN_percentageUnit", round (_value * 100), "%"]
    } else {
        if (_trailingDecimals < 0) then {
            _value = round _value;
        };

        [_value, 1, _trailingDecimals max 0] call CBA_fnc_formatNumber
    };

    private _ctrlSliderEdit = _controlsGroup controlsGroupCtrl IDC_SETTING_SLIDER_EDIT;
    _ctrlSliderEdit ctrlSetText _editText;

    SET_TEMP_NAMESPACE_VALUE(_setting,_value,_source);

    // if new value is same as default value, grey out the default button
    private _defaultValue = [_setting, "default"] call FUNC(get);
    ROW_ENABLE(_controlsGroup,IDC_SETTING_DEFAULT,_value isNotEqualTo _defaultValue);

    // automatically check "overwrite client" for mission makers qol
    [_controlsGroup, _source] call (_controlsGroup getVariable QFUNC(auto_check_overwrite));
    // refresh priority to update overwrite color if current value is equal to overwrite
    [_controlsGroup] call (_controlsGroup getVariable QFUNC(updateUI_locked));
}];

private _editText = if (_isPercentage) then {
    format [localize "STR_3DEN_percentageUnit", round (_currentValue * 100), "%"]
} else {
    [_currentValue, 1, _trailingDecimals max 0] call CBA_fnc_formatNumber
};

private _ctrlSliderEdit = _controlsGroup controlsGroupCtrl IDC_SETTING_SLIDER_EDIT;
_ctrlSliderEdit ctrlSetText _editText;

_ctrlSliderEdit ctrlAddEventHandler ["KeyUp", {
    params ["_ctrlSliderEdit"];

    private _controlsGroup = ctrlParentControlsGroup _ctrlSliderEdit;
    private _setting = ROW_SETTING(_controlsGroup);
    private _source = ROW_SOURCE(_controlsGroup);
    (_controlsGroup getVariable QGVAR(settingData)) params ["", "", "_trailingDecimals", "_isPercentage"];

    private _value = parseNumber ctrlText _ctrlSliderEdit;

    if (_isPercentage) then {
        _value = _value / 100;
    } else {
        if (_trailingDecimals < 0) then {
            _value = round _value;
        };
    };

    private _ctrlSlider = _controlsGroup controlsGroupCtrl IDC_SETTING_SLIDER;

    _ctrlSlider sliderSetPosition _value;
    _value = sliderPosition _ctrlSlider;

    SET_TEMP_NAMESPACE_VALUE(_setting,_value,_source);

    // if new value is same as default value, grey out the default button
    private _defaultValue = [_setting, "default"] call FUNC(get);
    ROW_ENABLE(_controlsGroup,IDC_SETTING_DEFAULT,_value isNotEqualTo _defaultValue);

    // automatically check "overwrite client" for mission makers qol
    [_controlsGroup, _source] call (_controlsGroup getVariable QFUNC(auto_check_overwrite));
    // refresh priority to update overwrite color if current value is equal to overwrite
    [_controlsGroup] call (_controlsGroup getVariable QFUNC(updateUI_locked));
}];

_ctrlSliderEdit ctrlAddEventHandler ["KillFocus", {
    params ["_ctrlSliderEdit"];

    private _controlsGroup = ctrlParentControlsGroup _ctrlSliderEdit;
    private _setting = ROW_SETTING(_controlsGroup);
    (_controlsGroup getVariable QGVAR(settingData)) params ["", "", "_trailingDecimals", "_isPercentage"];

    private _ctrlSlider = _controlsGroup controlsGroupCtrl IDC_SETTING_SLIDER;

    private _value = sliderPosition _ctrlSlider;

    private _editText = if (_isPercentage) then {
        format [localize "STR_3DEN_percentageUnit", round (_value * 100), "%"]
    } else {
        if (_trailingDecimals < 0) then {
            _value = round _value;
        };

        [_value, 1, _trailingDecimals max 0] call CBA_fnc_formatNumber
    };

    _ctrlSliderEdit ctrlSetText _editText;

    // if new value is same as default value, grey out the default button
    private _defaultValue = [_setting, "default"] call FUNC(get);
    ROW_ENABLE(_controlsGroup,IDC_SETTING_DEFAULT,_value isNotEqualTo _defaultValue);
}];

// set setting ui manually to new value
_controlsGroup setVariable [QFUNC(updateUI), {
    params ["_controlsGroup", "_value"];

    private _setting = ROW_SETTING(_controlsGroup);
    (_controlsGroup getVariable QGVAR(settingData)) params ["", "", "_trailingDecimals", "_isPercentage"];

    private _ctrlSlider = _controlsGroup controlsGroupCtrl IDC_SETTING_SLIDER;
    private _ctrlSliderEdit = _controlsGroup controlsGroupCtrl IDC_SETTING_SLIDER_EDIT;

    _ctrlSlider sliderSetPosition _value;

    private _editText = if (_isPercentage) then {
        format [localize "STR_3DEN_percentageUnit", round (_value * 100), "%"]
    } else {
        [_value, 1, _trailingDecimals max 0] call CBA_fnc_formatNumber
    };

    _ctrlSliderEdit ctrlSetText _editText;

    // if new value is same as default value, grey out the default button
    private _defaultValue = [_setting, "default"] call FUNC(get);
    ROW_ENABLE(_controlsGroup,IDC_SETTING_DEFAULT,_value isNotEqualTo _defaultValue);
}];
