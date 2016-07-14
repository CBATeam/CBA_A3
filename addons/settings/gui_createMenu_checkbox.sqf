// inline function, don't include script_component.hpp

private _ctrlSetting = _display ctrlCreate ["RscCheckBox", count _contols + IDC_OFFSET_SETTING, _ctrlOptionsGroup];
_contols pushBack _ctrlSetting;

_ctrlSetting ctrlSetPosition [
    POS_W(16),
    POS_H(_offsetY),
    POS_W(1),
    POS_H(1)
];
_ctrlSetting ctrlCommit 0;
_ctrlSetting cbSetChecked _currentValue;

private _data = [_setting, _source];

_ctrlSetting setVariable [QGVAR(linkedControls), _linkedControls];
_ctrlSetting setVariable [QGVAR(data), _data];

_ctrlSetting ctrlAddEventHandler ["CheckedChanged", {
    params ["_control", "_state"];

    (_control getVariable QGVAR(data)) params ["_setting", "_source"];

    private _value = _state == 1;
    SET_TEMP_NAMESPACE_VALUE(_setting,_value,_source);
}];

_linkedControls pushBack _ctrlSetting;

if (_isOverwritten) then {
    _ctrlSettingName ctrlSetTextColor COLOR_TEXT_OVERWRITTEN;
    _ctrlSetting ctrlSetTooltip localize LSTRING(overwritten_tooltip);
};

if !(_enabled) then {
    _ctrlSettingName ctrlSetTextColor COLOR_TEXT_DISABLED;
    _ctrlSetting ctrlEnable false;
};
