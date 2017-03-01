// inline function, don't include script_component.hpp

private _ctrlSettingPriority = _display ctrlCreate ["RscCombo", count _controls + IDC_OFFSET_SETTING, _ctrlOptionsGroup];
_controls pushBack _ctrlSettingPriority;

_ctrlSettingPriority ctrlSetPosition [
    POS_W(32),
    POS_H(_ctrlOptionsGroup getVariable QGVAR(offsetY)),
    POS_W(4),
    POS_H(1)
];
_ctrlSettingPriority ctrlCommit 0;

// @todo
private _data = [_setting, _source, []];

for "_i" from 0 to ([2,1] select (_source == "client")) do {
    private _tooltip = [
        LSTRING(priority_low),
        LSTRING(priority_medium),
        LSTRING(priority_high)
    ] select _i;

    _ctrlSettingPriority lbAdd localize _tooltip;

    (_data select 2) pushBack _i;
};

_ctrlSettingPriority lbSetCurSel ((_data select 2) find ([_setting, _source] call FUNC(getForced)));

_ctrlSettingPriority setVariable [QGVAR(linkedControls), _linkedControls];
_ctrlSettingPriority setVariable [QGVAR(data), _data];

_ctrlSettingPriority ctrlAddEventHandler ["LBSelChanged", {
    params ["_control", "_index"];

    (_control getVariable QGVAR(data)) params ["_setting", "_source", "_data"];

    private _value = _data select _index;

    SET_TEMP_NAMESPACE_FORCED(_setting,_value,_source);
}];

_linkedControls pushBack _ctrlSettingPriority;

if !(_enabled) then {
    _ctrlSettingPriority ctrlEnable false;
};

// is-active feedback checkbox
private _ctrlSettingActive = _display ctrlCreate ["RscPicture", count _controls + IDC_OFFSET_SETTING, _ctrlOptionsGroup];
_controls pushBack _ctrlSettingActive;

_ctrlSettingActive ctrlSetPosition [
    POS_W(36),
    POS_H(_ctrlOptionsGroup getVariable QGVAR(offsetY)),
    POS_W(1),
    POS_H(1)
];
_ctrlSettingActive ctrlCommit 0;

_ctrlSettingActive ctrlSetText selectRandom [ICON_OFF, ICON_ON];

_linkedControls pushBack _ctrlSettingActive;
