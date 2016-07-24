// inline function, don't include script_component.hpp

private _ctrlSettingDefault = _display ctrlCreate ["RscButtonMenu", count _controls + IDC_OFFSET_SETTING, _ctrlOptionsGroup];
_controls pushBack _ctrlSettingDefault;

_ctrlSettingDefault ctrlSetPosition [
    POS_W(27),
    POS_H(_ctrlOptionsGroup getVariable QGVAR(offsetY)),
    POS_W(5),
    POS_H(1)
];
_ctrlSettingDefault ctrlCommit 0;
_ctrlSettingDefault ctrlSetText localize LSTRING(Default);

private _data = [_setting, _source, _defaultValue, _settingType, _settingData];

_ctrlSettingDefault setVariable [QGVAR(linkedControls), _linkedControls];
_ctrlSettingDefault setVariable [QGVAR(data), _data];

_ctrlSettingDefault ctrlAddEventHandler ["ButtonClick", {
    params ["_control"];

    (_control getVariable QGVAR(data)) params ["_setting", "_source", "_defaultValue", "_settingType", "_settingData"];
    SET_TEMP_NAMESPACE_VALUE(_setting,_defaultValue,_source);

    _control ctrlEnable false;

    private _linkedControls = _control getVariable QGVAR(linkedControls);

    // reset buttons to default state
    switch (toUpper _settingType) do {
        case ("CHECKBOX"): {
            _linkedControls params ["_ctrlSetting"];

            _ctrlSetting cbSetChecked _defaultValue;
        };
        case ("LIST"): {
            _settingData params ["_values"];
            _linkedControls params ["_ctrlSetting"];

            _ctrlSetting lbSetCurSel (_values find _defaultValue);
        };
        case ("SLIDER"): {
            _settingData params ["", "", "_trailingDecimals"];
            _linkedControls params ["_ctrlSetting", "_ctrlSettingEdit"];

            _ctrlSetting sliderSetPosition _defaultValue;
            _ctrlSettingEdit ctrlSetText ([_defaultValue, 1, _trailingDecimals] call CBA_fnc_formatNumber);
        };
        case ("COLOR"): {
            _linkedControls params ["_ctrlSettingPreview", "_settingControls"];

            _defaultValue params [
                ["_r", 0, [0]],
                ["_g", 0, [0]],
                ["_b", 0, [0]],
                ["_a", 1, [0]]
            ];
            private _color = [_r, _g, _b, _a];
            _ctrlSettingPreview ctrlSetBackgroundColor _color;

            {
                _x params ["_ctrlSetting", "_ctrlSettingEdit"];
                private _value = _defaultValue select _forEachIndex;

                _ctrlSetting sliderSetPosition _value;
                _ctrlSettingEdit ctrlSetText ([_value, 1, 2] call CBA_fnc_formatNumber);
            } forEach _settingControls;
        };
        default {};
    };
}];

_linkedControls pushBack _ctrlSettingDefault;

if ((!_enabled) || {_currentValue isEqualTo _defaultValue}) then {
    _ctrlSettingDefault ctrlEnable false;
};
