#include "script_component.hpp"
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

params [["_setting", "", [""]], "_value"];

if (isNil "_value") exitWith {false};

(GVAR(default) getVariable [_setting, []]) params ["_defaultValue", "", ["_settingType", ""], "_settingData"];

switch (toUpper _settingType) do {
    case "CHECKBOX": {
        _value isEqualType false
    };
    case "EDITBOX": {
        _value isEqualType ""
    };
    case "LIST": {
        _settingData params ["_values"];
        _value in _values
    };
    case "SLIDER": {
        _settingData params ["_min", "_max", "_trailingDecimals"];
        _value isEqualType 0 && {_value >= _min} && {_value <= _max} && {(_trailingDecimals >= 0) || {(round _value) == _value}}
    };
    case "COLOR": {
        _value isEqualType [] && {count _value == count _defaultValue} && {_value isEqualTypeAll 0} && {{_x < 0 || _x > 1} count _value == 0}
    };
    case "TIME": {
        _settingData params ["_min", "_max"];
        _value isEqualType 0 && {_value >= _min} && {_value <= _max} && {round _value == _value} 
    };
    default {false};
};
