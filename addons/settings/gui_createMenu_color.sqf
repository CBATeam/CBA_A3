// inline function, don't include script_component.hpp

private _ctrlSettingPreview = _display ctrlCreate ["RscText", count _controls + IDC_OFFSET_SETTING, _ctrlOptionsGroup];
_controls pushBack _ctrlSettingPreview;

_ctrlSettingPreview ctrlSetPosition [
    POS_W(9.5),
    POS_H(_offsetY + MENU_OFFSET_COLOR),
    POS_W(6),
    POS_H(1)
];
_ctrlSettingPreview ctrlCommit 0;

_currentValue params [
    ["_r", 0, [0]],
    ["_g", 0, [0]],
    ["_b", 0, [0]],
    ["_a", 1, [0]]
];
private _color = [_r, _g, _b, _a];
_ctrlSettingPreview ctrlSetBackgroundColor _color;

private _data = [_setting, _source, _currentValue, _color];

_ctrlSettingPreview setVariable [QGVAR(linkedControls), _linkedControls];
_ctrlSettingPreview setVariable [QGVAR(data), _data];

_linkedControls append [_ctrlSettingPreview, []];

for "_index" from 0 to (((count _defaultValue max 3) min 4) - 1) do {
    private _ctrlSetting = _display ctrlCreate [SLIDER_TYPES param [_index, "RscXSliderH"], count _controls + IDC_OFFSET_SETTING, _ctrlOptionsGroup];
    _controls pushBack _ctrlSetting;

    _ctrlSetting ctrlSetPosition [
        POS_W(16),
        POS_H(_offsetY),
        POS_W(8),
        POS_H(1)
    ];
    _ctrlSetting ctrlCommit 0;

    _ctrlSetting sliderSetRange [0, 1];
    _ctrlSetting sliderSetPosition (_currentValue param [_index, 0]);

    _ctrlSetting setVariable [QGVAR(linkedControls), _linkedControls];
    _ctrlSetting setVariable [QGVAR(data), _data];
    _ctrlSetting setVariable [QGVAR(index), _index];

    _ctrlSetting ctrlAddEventHandler ["SliderPosChanged", {
        params ["_control", "_value"];

        (_control getVariable QGVAR(data)) params ["_setting", "_source", "_currentValue", "_color"];
        private _index = _control getVariable QGVAR(index);

        (_control getVariable QGVAR(linkedControls)) params ["", "_ctrlSettingPreview", "_linkedControls", "_defaultControl"];
        private _linkedControl = _linkedControls select _index select 1;
        _linkedControl ctrlSetText ([_value, 1, 2] call CBA_fnc_formatNumber);

        _currentValue set [_index, _value];
        _color set [_index, _value];
        _ctrlSettingPreview ctrlSetBackgroundColor _color;
        SET_TEMP_NAMESPACE_VALUE(_setting,_currentValue,_source);

        //If new setting is same as default value, grey out the default button
        (_defaultControl getVariable QGVAR(data)) params ["", "", "_defaultValue"];
        _defaultControl ctrlEnable (!(_currentValue isEqualTo _defaultValue));
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

    //_ctrlSettingEdit ctrlSetTextColor (SLIDER_COLORS param [_index, 0]);
    _ctrlSettingEdit ctrlSetActiveColor (SLIDER_COLORS param [_index, 0]);
    _ctrlSettingEdit ctrlSetText ([_currentValue param [_index, 0], 1, 2] call CBA_fnc_formatNumber);

    _ctrlSettingEdit setVariable [QGVAR(linkedControls), _linkedControls];
    _ctrlSettingEdit setVariable [QGVAR(data), _data];
    _ctrlSettingEdit setVariable [QGVAR(index), _index];

    _ctrlSettingEdit ctrlAddEventHandler ["KeyUp", {
        params ["_control"];

        private _value = parseNumber ctrlText _control;

        (_control getVariable QGVAR(data)) params ["_setting", "_source", "_currentValue", "_color"];
        private _index = _control getVariable QGVAR(index);

        (_control getVariable QGVAR(linkedControls)) params ["", "_ctrlSettingPreview", "_linkedControls", "_defaultControl"];

        private _linkedControl = _linkedControls select _index select 0;
        _linkedControl sliderSetPosition _value;

        _currentValue set [_index, sliderPosition _linkedControl];
        _color set [_index, _value];
        _ctrlSettingPreview ctrlSetBackgroundColor _color;
        SET_TEMP_NAMESPACE_VALUE(_setting,_currentValue,_source);

        //If new setting is same as default value, grey out the default button
        (_defaultControl getVariable QGVAR(data)) params ["", "", "_defaultValue"];
        _defaultControl ctrlEnable (!(_currentValue isEqualTo _defaultValue));
    }];

    _ctrlSettingEdit ctrlAddEventHandler ["KillFocus", {
        params ["_control"];

        private _index = _control getVariable QGVAR(index);

        (_control getVariable QGVAR(linkedControls)) params ["", "", "_linkedControls"];
        private _linkedControl = _linkedControls select _index select 0;

        private _value = sliderPosition _linkedControl;

        _control ctrlSetText ([_value, 1, 2] call CBA_fnc_formatNumber);
    }];

    (_linkedControls select 2) pushBack [_ctrlSetting, _ctrlSettingEdit];

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

    _offsetY = _offsetY + MENU_OFFSET_COLOR;
};

_offsetY = _offsetY + MENU_OFFSET_COLOR_NEG;
