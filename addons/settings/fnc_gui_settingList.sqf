#include "script_component.hpp"

params ["_controlsGroup", "_setting", "_source", "_currentValue", "_settingData"];
_settingData params ["_values", "_labels"];

private _ctrlList = _controlsGroup controlsGroupCtrl IDC_SETTING_LIST;

private _lbData = [];

{
    private _label = _labels select _forEachIndex;

    if (isLocalized _label) then {
        _label = localize _label;
    };

    private _index = _ctrlList lbAdd _label;
    _lbData set [_index, _x];
} forEach _values;

_ctrlList lbSetCurSel (_values find _currentValue);

_ctrlList setVariable [QGVAR(params), [_setting, _source, _lbData]];
_ctrlList ctrlAddEventHandler ["LBSelChanged", {
    EXIT_LOCKED;
    params ["_ctrlList", "_index"];
    (_ctrlList getVariable QGVAR(params)) params ["_setting", "_source", "_lbData"];

    private _value = _lbData select _index;
    SET_TEMP_NAMESPACE_VALUE(_setting,_value,_source);

    // if new value is same as default value, grey out the default button
    private _controlsGroup = ctrlParentControlsGroup _ctrlList;
    private _ctrlDefault = _controlsGroup controlsGroupCtrl IDC_SETTING_DEFAULT;
    private _defaultValue = [_setting, "default"] call FUNC(get);
    _ctrlDefault ctrlEnable !(_value isEqualTo _defaultValue);
}];

// set setting ui manually to new value
_controlsGroup setVariable [QFUNC(updateUI), {
    params ["_controlsGroup", "_value"];
    (_controlsGroup getVariable QGVAR(params)) params ["_values", "_labels"];

    private _ctrlList = _controlsGroup controlsGroupCtrl IDC_SETTING_LIST;
    LOCK;
    _ctrlList lbSetCurSel (_values find _value);
    UNLOCK;

    // if new value is same as default value, grey out the default button
    private _ctrlDefault = _controlsGroup controlsGroupCtrl IDC_SETTING_DEFAULT;
    private _defaultValue = [_setting, "default"] call FUNC(get);
    _ctrlDefault ctrlEnable !(_value isEqualTo _defaultValue);
}];
