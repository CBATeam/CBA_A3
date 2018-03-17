#include "script_component.hpp"

params ["_controlsGroup", "_setting", "_source", "_currentValue", "_settingData"];

_currentValue params [
    ["_r", 0, [0]],
    ["_g", 0, [0]],
    ["_b", 0, [0]],
    ["_a", 1, [0]]
];

private _color = [_r, _g, _b, _a];

for "_index" from 0 to ((count _currentValue max 3 min 4) - 1) do {
    private _ctrlColor = _controlsGroup controlsGroupCtrl (IDCS_SETTING_COLOR select _index);

    _ctrlColor sliderSetRange [0, 1];
    _ctrlColor sliderSetPosition (_currentValue param [_index, 0]);

    _ctrlColor setVariable [QGVAR(params), [_setting, _source, _currentValue, _color, _index]];
    _ctrlColor ctrlAddEventHandler ["SliderPosChanged", {
        params ["_ctrlColor", "_value"];
        (_ctrlColor getVariable QGVAR(params)) params ["_setting", "_source", "_currentValue", "_color", "_index"];

        private _controlsGroup = ctrlParentControlsGroup _ctrlColor;
        private _ctrlColorEdit = _controlsGroup controlsGroupCtrl (IDCS_SETTING_COLOR_EDIT select _index);
        _ctrlColorEdit ctrlSetText ([_value, 1, 2] call CBA_fnc_formatNumber);

        _currentValue set [_index, _value];
        _color set [_index, _value];

        private _ctrlColorPreview = _controlsGroup controlsGroupCtrl IDC_SETTING_COLOR_PREVIEW;
        _ctrlColorPreview ctrlSetBackgroundColor _color;

        SET_TEMP_NAMESPACE_VALUE(_setting,_currentValue,_source);

        // if new value is same as default value, grey out the default button
        private _ctrlDefault = _controlsGroup controlsGroupCtrl IDC_SETTING_DEFAULT;
        private _defaultValue = [_setting, "default"] call FUNC(get);
        _ctrlDefault ctrlEnable !(_currentValue isEqualTo _defaultValue);

        // automatically check "overwrite client" for mission makers qol
        [_controlsGroup, _source] call (_controlsGroup getVariable QFUNC(auto_check_overwrite));
    }];

    private _ctrlColorEdit = _controlsGroup controlsGroupCtrl (IDCS_SETTING_COLOR_EDIT select _index);
    _ctrlColorEdit ctrlSetText ([_currentValue param [_index, 0], 1, 2] call CBA_fnc_formatNumber);

    _ctrlColorEdit setVariable [QGVAR(params), [_setting, _source, _currentValue, _color, _index]];
    _ctrlColorEdit ctrlAddEventHandler ["KeyUp", {
        params ["_ctrlColorEdit"];
        (_ctrlColorEdit getVariable QGVAR(params)) params ["_setting", "_source", "_currentValue", "_color", "_index"];

        private _value = parseNumber ctrlText _ctrlColorEdit;

        private _controlsGroup = ctrlParentControlsGroup _ctrlColorEdit;
        private _ctrlColor = _controlsGroup controlsGroupCtrl (IDCS_SETTING_COLOR select _index);

        _ctrlColor sliderSetPosition _value;
        _value = sliderPosition _ctrlColor;

        _currentValue set [_index, _value];
        _color set [_index, _value];

        private _ctrlColorPreview = _controlsGroup controlsGroupCtrl IDC_SETTING_COLOR_PREVIEW;
        _ctrlColorPreview ctrlSetBackgroundColor _color;

        SET_TEMP_NAMESPACE_VALUE(_setting,_currentValue,_source);

        // if new value is same as default value, grey out the default button
        private _ctrlDefault = _controlsGroup controlsGroupCtrl IDC_SETTING_DEFAULT;
        private _defaultValue = [_setting, "default"] call FUNC(get);
        _ctrlDefault ctrlEnable !(_currentValue isEqualTo _defaultValue);

        // automatically check "overwrite client" for mission makers qol
        [_controlsGroup, _source] call (_controlsGroup getVariable QFUNC(auto_check_overwrite));
    }];

    _ctrlColorEdit ctrlAddEventHandler ["KillFocus", {
        params ["_ctrlColorEdit"];
        (_ctrlColorEdit getVariable QGVAR(params)) params ["_setting", "_source", "_currentValue", "_color", "_index"];

        private _controlsGroup = ctrlParentControlsGroup _ctrlColorEdit;
        private _ctrlColor = _controlsGroup controlsGroupCtrl (IDCS_SETTING_COLOR select _index);

        private _value = sliderPosition _ctrlColor;

        _currentValue set [_index, _value];
        _color set [_index, _value];

        _ctrlColorEdit ctrlSetText ([_value, 1, 2] call CBA_fnc_formatNumber);

        // if new value is same as default value, grey out the default button
        private _ctrlDefault = _controlsGroup controlsGroupCtrl IDC_SETTING_DEFAULT;
        private _defaultValue = [_setting, "default"] call FUNC(get);
        _ctrlDefault ctrlEnable !(_currentValue isEqualTo _defaultValue);
    }];
};

private _ctrlColorPreview = _controlsGroup controlsGroupCtrl IDC_SETTING_COLOR_PREVIEW;
_ctrlColorPreview ctrlSetBackgroundColor _color;
_ctrlColorPreview setVariable [QGVAR(color), _color];

// set setting ui manually to new value
_controlsGroup setVariable [QFUNC(updateUI), {
    params ["_controlsGroup", "_value"];

    private _ctrlColorPreview = _controlsGroup controlsGroupCtrl IDC_SETTING_COLOR_PREVIEW;
    private _color = _ctrlColorPreview getVariable QGVAR(color);

    {
        _color set [_forEachIndex, _x];

        private _ctrlColor = _controlsGroup controlsGroupCtrl (IDCS_SETTING_COLOR select _forEachIndex);
        _ctrlColor sliderSetPosition _x;

        private _ctrlColorEdit = _controlsGroup controlsGroupCtrl (IDCS_SETTING_COLOR_EDIT select _forEachIndex);
        _ctrlColorEdit ctrlSetText ([_x, 1, 2] call CBA_fnc_formatNumber);
    } forEach _value;

    _ctrlColorPreview ctrlSetBackgroundColor _color;

    private _ctrlDefault = _controlsGroup controlsGroupCtrl IDC_SETTING_DEFAULT;
    private _defaultValue = [_setting, "default"] call FUNC(get);
    _ctrlDefault ctrlEnable !(_value isEqualTo _defaultValue);
}];
