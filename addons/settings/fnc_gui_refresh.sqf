#include "script_component.hpp"

private _display = uiNamespace getVariable [QGVAR(display), displayNull];
private _ctrlOptionsGroup = ((_display getVariable [QGVAR(controls), []]) select {ctrlShown _x}) param [0, controlNull];
private _controls = _ctrlOptionsGroup getVariable [QGVAR(controls), []];

{
    private _linkedControls = _x getVariable QGVAR(linkedControls);
    (_x getVariable QGVAR(data)) params ["_setting", "_source"];
    (GVAR(defaultSettings) getVariable _setting) params ["_defaultValue", "", "_settingType", "_settingData"];

    private _value = GET_TEMP_NAMESPACE_VALUE(_setting,_source);

    // --- reset settings controls to current state
    if (!isNil "_value") then {
        switch (toUpper _settingType) do {
            case ("CHECKBOX"): {
                _linkedControls params ["_ctrlSetting", "_defaultControl"];

                _ctrlSetting cbSetChecked _value;

                _defaultControl ctrlEnable !(_value isEqualTo _defaultValue);
            };
            case ("LIST"): {
                _settingData params ["_values"];
                _linkedControls params ["_ctrlSetting", "_defaultControl"];

                _ctrlSetting lbSetCurSel (_values find _value);

                _defaultControl ctrlEnable !(_value isEqualTo _defaultValue);
            };
            case ("SLIDER"): {
                _settingData params ["", "", "_trailingDecimals"];
                _linkedControls params ["_ctrlSetting", "_ctrlSettingEdit", "_defaultControl"];

                _ctrlSetting sliderSetPosition _value;
                _ctrlSettingEdit ctrlSetText ([_value, 1, _trailingDecimals] call CBA_fnc_formatNumber);
                
                _defaultControl ctrlEnable !(_value isEqualTo _defaultValue);
            };
            case ("COLOR"): {
                _linkedControls params ["_ctrlSettingPreview", "_settingControls", "_defaultControl"];

                _value params [
                    ["_r", 0, [0]],
                    ["_g", 0, [0]],
                    ["_b", 0, [0]],
                    ["_a", 1, [0]]
                ];
                private _color = [_r, _g, _b, _a];
                _ctrlSettingPreview ctrlSetBackgroundColor _color;

                {
                    _x params ["_ctrlSetting", "_ctrlSettingEdit"];
                    private _valueX = _value select _forEachIndex;

                    _ctrlSetting sliderSetPosition _valueX;
                    _ctrlSettingEdit ctrlSetText ([_valueX, 1, 2] call CBA_fnc_formatNumber);
                } forEach _settingControls;

                _defaultControl ctrlEnable !(_value isEqualTo _defaultValue);
            };
            default {};
        };
    };

    private _forced = GET_TEMP_NAMESPACE_FORCED(_setting,_source);

    // --- reset force buttons to current state
    if (!isNil "_forced") then {
        switch (toUpper _settingType) do {
            case ("CHECKBOX");
            case ("LIST"): {
                private _ctrlSettingForce = _linkedControls param [2, controlNull];
                _ctrlSettingForce cbSetChecked _forced;
            };
            case ("SLIDER");
            case ("COLOR"): {
                private _ctrlSettingForce = _linkedControls param [3, controlNull];
                _ctrlSettingForce cbSetChecked _forced;
            };
            default {};
        };
    };
} forEach _controls;
