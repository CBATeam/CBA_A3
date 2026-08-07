#include "script_component.hpp"

params ["_controlsGroup", "_setting", "_source", "_currentValue", "_defaultValue"];

private _ctrlDefault = _controlsGroup controlsGroupCtrl IDC_SETTING_DEFAULT;

_ctrlDefault ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlDefault"];

    private _controlsGroup = ctrlParentControlsGroup _ctrlDefault;
    private _setting = ROW_SETTING(_controlsGroup);
    private _source = ROW_SOURCE(_controlsGroup);

    private _defaultValue = [_setting, "default"] call FUNC(get);
    SET_TEMP_NAMESPACE_VALUE(_setting,_defaultValue,_source);

    // can disable button as the setting will now be the default
    _ctrlDefault ctrlEnable false;

    // take focus off whatever was being edited; control 999 is hidden when the
    // menu is opened with FUNC(openSettingsMenu)
    ctrlSetFocus _ctrlDefault;

    [_controlsGroup, _defaultValue] call (_controlsGroup getVariable QFUNC(updateUI));
    // refresh priority to update overwrite color if current value is equal to overwrite
    [_controlsGroup] call (_controlsGroup getVariable QFUNC(updateUI_locked));

    private _ctrlSettingName = _controlsGroup controlsGroupCtrl IDC_SETTING_NAME;
    _ctrlSettingName ctrlSetTextColor COLOR_TEXT_ENABLED_WAS_EDITED;
}];

if (_currentValue isEqualTo _defaultValue) then {
    _ctrlDefault ctrlEnable false;
};
