#include "script_component.hpp"

params ["_controlsGroup", "_setting", "_source", "_currentValue", "_defaultValue"];

private _ctrlDefault = _controlsGroup controlsGroupCtrl IDC_SETTING_DEFAULT;

_ctrlDefault setVariable [QGVAR(params), [_setting, _source]];
_ctrlDefault ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlDefault"];
    (_ctrlDefault getVariable QGVAR(params)) params ["_setting", "_source"];

    private _defaultValue = [_setting, "default"] call FUNC(get);
    SET_TEMP_NAMESPACE_VALUE(_setting,_defaultValue,_source);

    // can disable button as the setting will now be the default
    _ctrlDefault ctrlEnable false;
    ctrlSetFocus (ctrlParent _ctrlDefault displayCtrl 999);

    private _controlsGroup = ctrlParentControlsGroup _ctrlDefault;
    [_controlsGroup, _defaultValue] call (_controlsGroup getVariable QFUNC(updateUI));
    // refresh priority to update overwrite color if current value is equal to overwrite
    [_controlsGroup] call (_controlsGroup getVariable QFUNC(updateUI_locked));

    private _ctrlSettingName = _controlsGroup controlsGroupCtrl IDC_SETTING_NAME;
    _ctrlSettingName ctrlSetTextColor COLOR_TEXT_ENABLED_WAS_EDITED;
}];

if (_currentValue isEqualTo _defaultValue) then {
    _ctrlDefault ctrlEnable false;
};
