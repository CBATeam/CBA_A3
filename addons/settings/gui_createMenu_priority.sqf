// inline function, don't include script_component.hpp

private _ctrlSettingForce = _display ctrlCreate ["RscCombo", count _controls + IDC_OFFSET_SETTING, _ctrlOptionsGroup];
_controls pushBack _ctrlSettingForce;

_ctrlSettingForce ctrlSetPosition [
    POS_W(32),
    POS_H(_ctrlOptionsGroup getVariable QGVAR(offsetY)),
    POS_W(2),
    POS_H(1)
];
_ctrlSettingForce ctrlCommit 0;

// @todo
private _data = [_setting, _source, []];

private _priorities = [];

switch (_source) do {
    case "server": {
        _priorities append [0,2,4];
    };
    case "client": {
        _priorities append [-1,1];
    };
    case "mission": {
        _priorities append [0,3];
    };
};

{
    private _index = _ctrlSettingForce lbAdd str _x;
    _ctrlSettingForce lbSetTooltip [_index, "-tooltip-"];

    (_data select 2) pushBack _x;
} forEach _priorities;

_ctrlSettingForce lbSetCurSel ((_data select 2) find ([_setting, _source] call FUNC(getForced)));

_ctrlSettingForce setVariable [QGVAR(linkedControls), _linkedControls];
_ctrlSettingForce setVariable [QGVAR(data), _data];

_ctrlSettingForce ctrlAddEventHandler ["LBSelChanged", {
    params ["_control", "_index"];

    (_control getVariable QGVAR(data)) params ["_setting", "_source", "_data"];

    private _value = _data select _index;

    SET_TEMP_NAMESPACE_FORCED(_setting,_value,_source);
}];

_linkedControls pushBack _ctrlSettingForce;

if !(_enabled) then {
    _ctrlSettingForce ctrlEnable false;
};
