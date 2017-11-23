#include "script_component.hpp"

params ["_controlsGroup", "_setting", "_source", "_currentValue", "_settingData"];
_settingData params ["_isPassword", "_fnc_sanitizeValue"];

if (_isPassword) then {
    if ((_source isEqualTo "server" && {!CAN_SET_SERVER_SETTINGS}) || {_source isEqualTo "mission" && {!CAN_SET_MISSION_SETTINGS}}) then {
        _currentValue = "********";
    };
};

private _ctrlEditbox = _controlsGroup controlsGroupCtrl IDC_SETTING_EDITBOX;
_ctrlEditbox ctrlSetText _currentValue;

_ctrlEditbox setVariable [QGVAR(params), [_setting, _source, _fnc_sanitizeValue]];
_ctrlEditbox ctrlAddEventHandler ["KeyDown", {
    params ["_ctrlEditbox"];
    (_ctrlEditbox getVariable QGVAR(params)) params ["", "", "_fnc_sanitizeValue"];

    private _value = ctrlText _ctrlEditbox;
    _value = _value call _fnc_sanitizeValue;
    _ctrlEditbox ctrlSetText _value;
}];

_ctrlEditbox ctrlAddEventHandler ["KeyUp", {
    params ["_ctrlEditbox"];
    (_ctrlEditbox getVariable QGVAR(params)) params ["_setting", "_source", "_fnc_sanitizeValue"];

    private _value = ctrlText _ctrlEditbox;
    _value = _value call _fnc_sanitizeValue;
    _ctrlEditbox ctrlSetText _value;
    SET_TEMP_NAMESPACE_VALUE(_setting,_value,_source);

    // if new value is same as default value, grey out the default button
    private _controlsGroup = ctrlParentControlsGroup _ctrlEditbox;
    private _ctrlDefault = _controlsGroup controlsGroupCtrl IDC_SETTING_DEFAULT;
    private _defaultValue = [_setting, "default"] call FUNC(get);
    _ctrlDefault ctrlEnable !(_value isEqualTo _defaultValue);
}];

// set setting ui manually to new value
_controlsGroup setVariable [QFUNC(updateUI), {
    params ["_controlsGroup", "_value"];

    private _ctrlEditbox = _controlsGroup controlsGroupCtrl IDC_SETTING_EDITBOX;
    _ctrlEditbox ctrlSetText _value;

    // if new value is same as default value, grey out the default button
    private _ctrlDefault = _controlsGroup controlsGroupCtrl IDC_SETTING_DEFAULT;
    private _defaultValue = [_setting, "default"] call FUNC(get);
    _ctrlDefault ctrlEnable !(_value isEqualTo _defaultValue);
}];
