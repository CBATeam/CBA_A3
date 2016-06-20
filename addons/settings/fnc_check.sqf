/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_check

Description:
    Check if provided value is valid.

Parameters:
    _setting - Name of the setting <STRING>
    _value   - Value of to test <ANY>

Returns:
    _return - true: Tested value is accepted for setting, false: Wrong value for setting

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [["_setting", "", [""]], "_value"];

if (isNil "_value") exitWith {false};

([GVAR(defaultSettings) getVariable _setting] param [0, []]) params ["_defaultValue", "", ["_settingType", ""], "_settingData"];

switch (toUpper _settingType) do {
    case ("CHECKBOX"): {
        _value isEqualType false
    };
    case ("LIST"): {
        _settingData params ["_values"];
        _value in _values
    };
    case ("SLIDER"): {
        _settingData params ["_min", "_max"];
        _value isEqualType 0 && {_value >= _min} && {_value <= _max}
    };
    case ("COLOR"): {
        _value isEqualType [] && {count _value == count _defaultValue} && {_value isEqualTypeAll 0} && {{_x < 0 || _x > 1} count _value == 0}
    };
    default {false};
};
