#include "script_component.hpp"

params ["_controlsGroup", "_setting", "_source", "_currentValue", "_settingData"];

private _ctrlEditbox = _controlsGroup controlsGroupCtrl IDC_SETTING_EDITBOX;

_ctrlEditbox ctrlAddEventHandler ["KeyDown", {
    params ["_ctrlEditbox"];

    private _controlsGroup = ctrlParentControlsGroup _ctrlEditbox;
    (_controlsGroup getVariable QGVAR(settingData)) params ["", "_fnc_sanitizeValue"];

    private _value = ctrlText _ctrlEditbox;
    _value = _value call _fnc_sanitizeValue;
    _ctrlEditbox ctrlSetText _value;
}];

_ctrlEditbox ctrlAddEventHandler ["KeyUp", {
    params ["_ctrlEditbox"];

    private _controlsGroup = ctrlParentControlsGroup _ctrlEditbox;
    private _setting = ROW_SETTING(_controlsGroup);
    private _source = ROW_SOURCE(_controlsGroup);
    (_controlsGroup getVariable QGVAR(settingData)) params ["", "_fnc_sanitizeValue"];

    private _value = ctrlText _ctrlEditbox;
    _value = _value call _fnc_sanitizeValue;
    _ctrlEditbox ctrlSetText _value;
    SET_TEMP_NAMESPACE_VALUE(_setting,_value,_source);

    // if new value is same as default value, grey out the default button
    private _ctrlDefault = _controlsGroup controlsGroupCtrl IDC_SETTING_DEFAULT;
    private _defaultValue = [_setting, "default"] call FUNC(get);
    _ctrlDefault ctrlEnable (_value isNotEqualTo _defaultValue);

    // automatically check "overwrite client" for mission makers qol
    [_controlsGroup, _source] call (_controlsGroup getVariable QFUNC(auto_check_overwrite));
    // refresh priority to update overwrite color if current value is equal to overwrite
    [_controlsGroup] call (_controlsGroup getVariable QFUNC(updateUI_locked));
}];

// set setting ui manually to new value
_controlsGroup setVariable [QFUNC(updateUI), {
    params ["_controlsGroup", "_value"];

    private _setting = ROW_SETTING(_controlsGroup);
    private _source = ROW_SOURCE(_controlsGroup);

    // A password is hidden whenever it can't be edited anyway, so the box is
    // always disabled when this replaces the value and KeyUp can never write the
    // mask back over the real one. Has to happen every time the value is set, not
    // just when the row is created, or importing puts the real one on screen.
    if ((_controlsGroup getVariable QGVAR(settingData)) param [0, false]) then {
        if ((_source isEqualTo "server" && {!CAN_SET_SERVER_SETTINGS}) || {_source isEqualTo "mission" && {!CAN_SET_MISSION_SETTINGS}}) then {
            _value = "********";
        };
    };

    private _ctrlEditbox = _controlsGroup controlsGroupCtrl IDC_SETTING_EDITBOX;
    _ctrlEditbox ctrlSetText _value;

    // if new value is same as default value, grey out the default button
    private _ctrlDefault = _controlsGroup controlsGroupCtrl IDC_SETTING_DEFAULT;
    private _defaultValue = [_setting, "default"] call FUNC(get);
    _ctrlDefault ctrlEnable (_value isNotEqualTo _defaultValue);
}];

[_controlsGroup, _currentValue] call (_controlsGroup getVariable QFUNC(updateUI));
