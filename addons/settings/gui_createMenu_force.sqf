// inline function, don't include script_component.hpp

private _ctrlSettingForce = _display ctrlCreate ["RscCheckBox", count _contols + IDC_OFFSET_SETTING, _ctrlOptionsGroup];
_contols pushBack _ctrlSettingForce;

_ctrlSettingForce ctrlSetPosition [
    POS_W(33),
    POS_H(_ctrlOptionsGroup getVariable QGVAR(offsetY)),
    POS_W(1),
    POS_H(1)
];
_ctrlSettingForce ctrlCommit 0;
_ctrlSettingForce cbSetChecked ([_setting, _source] call FUNC(isForced));

private _data = [_setting, _source];

_ctrlSettingForce setVariable [QGVAR(linkedControls), _linkedControls];
_ctrlSettingForce setVariable [QGVAR(data), _data];

if (_isGlobal) then {
    _ctrlSettingForce ctrlSetChecked true;
    _ctrlSettingForce ctrlEnable false;
};

_ctrlSettingForce ctrlAddEventHandler ["CheckedChanged", {
    params ["_control", "_state"];

    private _value = _state == 1;

    (_control getVariable QGVAR(data)) params ["_setting", "_source"];
    SET_TEMP_NAMESPACE_FORCED(_setting,_value,_source);
}];

_linkedControls pushBack _ctrlSettingForce;

if !(_enabled) then {
    _ctrlSettingForce ctrlEnable false;
};
