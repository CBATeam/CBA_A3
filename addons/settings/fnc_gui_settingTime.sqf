#include "script_component.hpp"

params ["_controlsGroup", "_setting", "_source", "_currentValue", "_settingData"];
_settingData params ["_min", "_max"];

private _ctrlSlider = _controlsGroup controlsGroupCtrl IDC_SETTING_TIME_SLIDER;
_ctrlSlider setVariable [QGVAR(params), [_setting, _source]];

_ctrlSlider sliderSetRange [_min, _max];
_ctrlSlider sliderSetPosition _currentValue;
private _range = _max - _min;
_ctrlSlider sliderSetSpeed [0.05 * _range, 0.1 * _range];

_ctrlSlider ctrlAddEventHandler ["SliderPosChanged", {
    params ["_ctrlSlider", "_value"];
    (_ctrlSlider getVariable QGVAR(params)) params ["_setting", "_source"];
    _value = round _value;

    private _controlsGroup = ctrlParentControlsGroup _ctrlSlider;

    {
        _x params ["_idc", "_value"];

        private _ctrlEdit = _controlsGroup controlsGroupCtrl _idc;
        private _editText = if (_value < 10) then {format ["0%1", _value]} else {str _value};
        _ctrlEdit ctrlSetText _editText;
    } forEach [
        [IDC_SETTING_TIME_HOURS, floor (_value / 3600)],
        [IDC_SETTING_TIME_MINUTES, floor (_value / 60 % 60)],
        [IDC_SETTING_TIME_SECONDS, floor (_value % 60)]
    ];

    SET_TEMP_NAMESPACE_VALUE(_setting,_value,_source);

    // if new value is same as default value, grey out the default button
    private _ctrlDefault = _controlsGroup controlsGroupCtrl IDC_SETTING_DEFAULT;
    private _defaultValue = [_setting, "default"] call FUNC(get);
    _ctrlDefault ctrlEnable !(_value isEqualTo _defaultValue);

    // automatically check "overwrite client" for mission makers qol
    [_controlsGroup, _source] call (_controlsGroup getVariable QFUNC(auto_check_overwrite));
}];

{
    _x params ["_idc", "_value"];

    private _ctrlEdit = _controlsGroup controlsGroupCtrl _idc;
    _ctrlEdit setVariable [QGVAR(params), [_setting, _source]];
    private _editText = if (_value < 10) then {format ["0%1", _value]} else {str _value};
    _ctrlEdit ctrlSetText _editText;

    _ctrlEdit ctrlAddEventHandler ["KillFocus", {
        params ["_ctrlEdit"];
        (_ctrlEdit getVariable QGVAR(params)) params ["_setting", "_source"];

        private _controlsGroup = ctrlParentControlsGroup _ctrlEdit;
        private _ctrlSlider = _controlsGroup controlsGroupCtrl IDC_SETTING_TIME_SLIDER;
        private _ctrlEditHours = _controlsGroup controlsGroupCtrl IDC_SETTING_TIME_HOURS;
        private _ctrlEditMinutes = _controlsGroup controlsGroupCtrl IDC_SETTING_TIME_MINUTES;
        private _ctrlEditSeconds = _controlsGroup controlsGroupCtrl IDC_SETTING_TIME_SECONDS;

        private _value = round (parseNumber ctrlText _ctrlEditHours * 3600 + parseNumber ctrlText _ctrlEditMinutes * 60 + parseNumber ctrlText _ctrlEditSeconds);
        _ctrlSlider sliderSetPosition _value;
        _value = sliderPosition _ctrlSlider;

        {
            _x params ["_idc", "_value"];

            private _ctrlEdit = _controlsGroup controlsGroupCtrl _idc;
            private _editText = if (_value < 10) then {format ["0%1", _value]} else {str _value};
            _ctrlEdit ctrlSetText _editText;
        } forEach [
            [IDC_SETTING_TIME_HOURS, floor (_value / 3600)],
            [IDC_SETTING_TIME_MINUTES, floor (_value / 60 % 60)],
            [IDC_SETTING_TIME_SECONDS, floor (_value % 60)]
        ];

        SET_TEMP_NAMESPACE_VALUE(_setting,_value,_source);

        // if new value is same as default value, grey out the default button
        private _ctrlDefault = _controlsGroup controlsGroupCtrl IDC_SETTING_DEFAULT;
        private _defaultValue = [_setting, "default"] call FUNC(get);
        _ctrlDefault ctrlEnable !(_value isEqualTo _defaultValue);
    }];
} forEach [
    [IDC_SETTING_TIME_HOURS, floor (_currentValue / 3600)],
    [IDC_SETTING_TIME_MINUTES, floor (_currentValue / 60 % 60)],
    [IDC_SETTING_TIME_SECONDS, floor (_currentValue % 60)]
];

// set setting ui manually to new value
_controlsGroup setVariable [QFUNC(updateUI), {
    params ["_controlsGroup", "_value"];

    private _ctrlSlider = _controlsGroup controlsGroupCtrl IDC_SETTING_TIME_SLIDER;
    _ctrlSlider sliderSetPosition _value;

    {
        _x params ["_idc", "_value"];

        private _ctrlEdit = _controlsGroup controlsGroupCtrl _idc;
        private _editText = if (_value < 10) then {format ["0%1", _value]} else {str _value};
        _ctrlEdit ctrlSetText _editText;
    } forEach [
        [IDC_SETTING_TIME_HOURS, floor (_value / 3600)],
        [IDC_SETTING_TIME_MINUTES, floor (_value / 60 % 60)],
        [IDC_SETTING_TIME_SECONDS, floor (_value % 60)]
    ];

    // if new value is same as default value, grey out the default button
    private _ctrlDefault = _controlsGroup controlsGroupCtrl IDC_SETTING_DEFAULT;
    private _defaultValue = [_setting, "default"] call FUNC(get);
    _ctrlDefault ctrlEnable !(_value isEqualTo _defaultValue);
}];
