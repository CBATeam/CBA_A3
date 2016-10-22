// inline function, don't include script_component.hpp

private _ctrlSetting = _display ctrlCreate ["RscXSliderH", count _controls + IDC_OFFSET_SETTING, _ctrlOptionsGroup];
_controls pushBack _ctrlSetting;

_ctrlSetting ctrlSetPosition [
    POS_W(16),
    POS_H(_offsetY),
    POS_W(8),
    POS_H(1)
];
_ctrlSetting ctrlCommit 0;

_settingData params ["_min", "_max", "_trailingDecimals"];

_ctrlSetting sliderSetRange [_min, _max];
_ctrlSetting sliderSetPosition _currentValue;

private _data = [_setting, _source, _trailingDecimals];

_ctrlSetting setVariable [QGVAR(linkedControls), _linkedControls];
_ctrlSetting setVariable [QGVAR(data), _data];

_ctrlSetting ctrlAddEventHandler ["SliderPosChanged", {
    params ["_control", "_value"];

    (_control getVariable QGVAR(data)) params ["_setting", "_source", "_trailingDecimals"];

    (_control getVariable QGVAR(linkedControls)) params ["", "", "_linkedControl", "_defaultControl"];
    _linkedControl ctrlSetText ([_value, 1, _trailingDecimals] call CBA_fnc_formatNumber);

    SET_TEMP_NAMESPACE_VALUE(_setting,_value,_source);
    
    //If new setting is same as default value, grey out the default button
    (_defaultControl getVariable QGVAR(data)) params ["", "", "_defaultValue"];
    _defaultControl ctrlEnable (!(_value isEqualTo _defaultValue));
}];

private _ctrlSettingEdit = _display ctrlCreate ["RscEdit", count _controls + IDC_OFFSET_SETTING, _ctrlOptionsGroup];
_controls pushBack _ctrlSettingEdit;

_ctrlSettingEdit ctrlSetPosition [
    POS_W(24),
    POS_H(_offsetY),
    POS_W(2),
    POS_H(1)
];
_ctrlSettingEdit ctrlCommit 0;
_ctrlSettingEdit ctrlSetText ([_currentValue, 1, _trailingDecimals] call CBA_fnc_formatNumber);

_ctrlSettingEdit setVariable [QGVAR(linkedControls), _linkedControls];
_ctrlSettingEdit setVariable [QGVAR(data), _data];

_ctrlSettingEdit ctrlAddEventHandler ["KeyUp", {
    params ["_control"];

    (_control getVariable QGVAR(data)) params ["_setting", "_source", "_trailingDecimals"];

    private _value = parseNumber ctrlText _control;

    (_control getVariable QGVAR(linkedControls)) params ["", "_linkedControl", "", "_defaultControl"];
    _linkedControl sliderSetPosition _value;

    _value = sliderPosition _linkedControl;
    SET_TEMP_NAMESPACE_VALUE(_setting,_value,_source);

    //If new setting is same as default value, grey out the default button
    (_defaultControl getVariable QGVAR(data)) params ["", "", "_defaultValue"];
    _defaultControl ctrlEnable (!(_value isEqualTo _defaultValue));
}];

_ctrlSettingEdit ctrlAddEventHandler ["KillFocus", {
    params ["_control"];

    (_control getVariable QGVAR(data)) params ["", "", "_trailingDecimals"];

    (_control getVariable QGVAR(linkedControls)) params ["", "_linkedControl"];
    private _value = sliderPosition _linkedControl;

    _control ctrlSetText ([_value, 1, _trailingDecimals] call CBA_fnc_formatNumber);
}];

_linkedControls append [_ctrlSetting, _ctrlSettingEdit];

if (_isOverwritten) then {
    _ctrlSettingName ctrlSetTextColor COLOR_TEXT_OVERWRITTEN;
    _ctrlSetting ctrlSetTooltip localize LSTRING(overwritten_tooltip);
    _ctrlSettingEdit ctrlSetTooltip localize LSTRING(overwritten_tooltip);
};

if !(_enabled) then {
    _ctrlSettingName ctrlSetTextColor COLOR_TEXT_DISABLED;
    _ctrlSetting ctrlEnable false;
    _ctrlSettingEdit ctrlEnable false;
};
