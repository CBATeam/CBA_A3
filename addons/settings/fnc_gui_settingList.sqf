#include "script_component.hpp"

params ["_controlsGroup", "_setting", "_source", "_currentValue", "_settingData"];
_settingData params ["_values", "_labels", "_tooltips"];

private _ctrlList = _controlsGroup controlsGroupCtrl IDC_SETTING_LIST;

private _lbData = [];

{
    private _label = _labels select _forEachIndex;
    private _tooltip = _tooltips select _forEachIndex;

    if (isLocalized _label) then {
        _label = localize _label;
    };

    if (isLocalized _tooltip) then {
        _tooltip = localize _tooltip;
    };

    if (_tooltip isEqualTo "") then {
        _tooltip = localize "str_a3_firing_drills_hint_time_raw" + str _x;
    } else {
        _tooltip = _tooltip + endl + localize "str_a3_firing_drills_hint_time_raw" + str _x;
    };

    private _index = _ctrlList lbAdd _label;
    _ctrlList lbSetTooltip [_index, _tooltip];
    _lbData set [_index, _x];
} forEach _values;

// Don't show tooltip if lb is not expanded. It's bugged and shows the wrong one
// if the item was changed by command. E.g. by clicking the "Default"-button.
_ctrlList ctrlSetTooltip "";

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

    // automatically check "overwrite client" for mission makers qol
    [_controlsGroup, _source] call (_controlsGroup getVariable QFUNC(auto_check_overwrite));
    // refresh priority to update overwrite color if current value is equal to overwrite
    [_controlsGroup] call (_controlsGroup getVariable QFUNC(updateUI_locked));
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
