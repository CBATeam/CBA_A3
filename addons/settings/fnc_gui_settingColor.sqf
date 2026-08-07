#include "script_component.hpp"

params ["_controlsGroup", "_setting", "_source", "_currentValue", "_settingData"];

private _channels = count _currentValue max 3 min 4;
_controlsGroup setVariable [QGVAR(channels), _channels];

// The sliders hold the value. Reading it back off them means nothing has to be
// kept in step with them, and the row can be pointed at another source without
// dragging a stale copy along.
_controlsGroup setVariable [QFUNC(readColor), {
    params ["_controlsGroup"];

    (IDCS_SETTING_COLOR select [0, _controlsGroup getVariable QGVAR(channels)]) apply {
        sliderPosition (_controlsGroup controlsGroupCtrl _x)
    }
}];

// ----- store the value and tell the rest of the row about it
_controlsGroup setVariable [QFUNC(commitColor), {
    params ["_controlsGroup"];

    private _setting = ROW_SETTING(_controlsGroup);
    private _source = ROW_SOURCE(_controlsGroup);
    private _value = _controlsGroup call (_controlsGroup getVariable QFUNC(readColor));

    private _ctrlColorPreview = _controlsGroup controlsGroupCtrl IDC_SETTING_COLOR_PREVIEW;
    _ctrlColorPreview ctrlSetBackgroundColor [_value param [0, 0], _value param [1, 0], _value param [2, 0], _value param [3, 1]];

    SET_TEMP_NAMESPACE_VALUE(_setting,_value,_source);

    // if new value is same as default value, grey out the default button
    private _defaultValue = [_setting, "default"] call FUNC(get);
    ROW_ENABLE(_controlsGroup,IDC_SETTING_DEFAULT,_value isNotEqualTo _defaultValue);

    // automatically check "overwrite client" for mission makers qol
    [_controlsGroup, _source] call (_controlsGroup getVariable QFUNC(auto_check_overwrite));
    // refresh priority to update overwrite color if current value is equal to overwrite
    [_controlsGroup] call (_controlsGroup getVariable QFUNC(updateUI_locked));
}];

for "_index" from 0 to (_channels - 1) do {
    private _ctrlColor = _controlsGroup controlsGroupCtrl (IDCS_SETTING_COLOR select _index);
    private _ctrlColorEdit = _controlsGroup controlsGroupCtrl (IDCS_SETTING_COLOR_EDIT select _index);

    _ctrlColor sliderSetRange [0, 1];
    _ctrlColor sliderSetPosition (_currentValue param [_index, 0]);
    _ctrlColor sliderSetSpeed [0.05, 0.1];

    _ctrlColor setVariable [QGVAR(index), _index];
    _ctrlColorEdit setVariable [QGVAR(index), _index];

    _ctrlColor ctrlAddEventHandler ["SliderPosChanged", {
        params ["_ctrlColor", "_value"];

        private _controlsGroup = ctrlParentControlsGroup _ctrlColor;
        private _index = _ctrlColor getVariable QGVAR(index);

        (_controlsGroup controlsGroupCtrl (IDCS_SETTING_COLOR_EDIT select _index)) ctrlSetText ([_value, 1, 2] call CBA_fnc_formatNumber);

        _controlsGroup call (_controlsGroup getVariable QFUNC(commitColor));
    }];

    _ctrlColorEdit ctrlSetText ([_currentValue param [_index, 0], 1, 2] call CBA_fnc_formatNumber);

    _ctrlColorEdit ctrlAddEventHandler ["KeyUp", {
        params ["_ctrlColorEdit"];

        private _controlsGroup = ctrlParentControlsGroup _ctrlColorEdit;
        private _index = _ctrlColorEdit getVariable QGVAR(index);
        private _ctrlColor = _controlsGroup controlsGroupCtrl (IDCS_SETTING_COLOR select _index);

        _ctrlColor sliderSetPosition (parseNumber ctrlText _ctrlColorEdit);

        _controlsGroup call (_controlsGroup getVariable QFUNC(commitColor));
    }];

    _ctrlColorEdit ctrlAddEventHandler ["KillFocus", {
        params ["_ctrlColorEdit"];

        private _controlsGroup = ctrlParentControlsGroup _ctrlColorEdit;
        private _index = _ctrlColorEdit getVariable QGVAR(index);
        private _ctrlColor = _controlsGroup controlsGroupCtrl (IDCS_SETTING_COLOR select _index);

        // put the box back in step with the slider, it clamps what was typed
        _ctrlColorEdit ctrlSetText ([sliderPosition _ctrlColor, 1, 2] call CBA_fnc_formatNumber);

        _controlsGroup call (_controlsGroup getVariable QFUNC(commitColor));
    }];
};

private _ctrlColorPreview = _controlsGroup controlsGroupCtrl IDC_SETTING_COLOR_PREVIEW;
_ctrlColorPreview ctrlSetBackgroundColor [_currentValue param [0, 0], _currentValue param [1, 0], _currentValue param [2, 0], _currentValue param [3, 1]];

// set setting ui manually to new value
_controlsGroup setVariable [QFUNC(updateUI), {
    params ["_controlsGroup", "_value"];

    private _setting = ROW_SETTING(_controlsGroup);

    {
        (_controlsGroup controlsGroupCtrl (IDCS_SETTING_COLOR select _forEachIndex)) sliderSetPosition _x;
        (_controlsGroup controlsGroupCtrl (IDCS_SETTING_COLOR_EDIT select _forEachIndex)) ctrlSetText ([_x, 1, 2] call CBA_fnc_formatNumber);
    } forEach _value;

    private _ctrlColorPreview = _controlsGroup controlsGroupCtrl IDC_SETTING_COLOR_PREVIEW;
    _ctrlColorPreview ctrlSetBackgroundColor [_value param [0, 0], _value param [1, 0], _value param [2, 0], _value param [3, 1]];

    private _defaultValue = [_setting, "default"] call FUNC(get);
    ROW_ENABLE(_controlsGroup,IDC_SETTING_DEFAULT,_value isNotEqualTo _defaultValue);
}];
