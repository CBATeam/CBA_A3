#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_addSetting

Description:
    Creates a new setting for that session.

Parameters:
    _setting     - Unique setting name. Matches resulting variable name <STRING>
    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <BOOL, NUMBER>
    _script      - Script to execute when setting is changed. (optional) <CODE>
    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>

Returns:
    _return - Error code <BOOLEAN>
        true: Success, no error
        false: Failure, error

Examples:
    (begin example)
        // CHECKBOX --- extra argument: default value
        ["Test_Setting_1", "CHECKBOX", ["-test checkbox-", "-tooltip-"], "My Category", true] call CBA_fnc_addSetting;

        // LIST --- extra arguments: [_values, _valueTitles, _defaultIndex]
        ["Test_Setting_2", "LIST",     ["-test list-",     "-tooltip-"], "My Category", [[1, 0], ["enabled","disabled"], 1]] call CBA_fnc_addSetting;

        // SLIDER --- extra arguments: [_min, _max, _default, _trailingDecimals, _isPercentage]
        ["Test_Setting_3", "SLIDER",   ["-test slider-",   "-tooltip-"], "My Category", [0, 10, 5, 0]] call CBA_fnc_addSetting;

        // COLOR PICKER --- extra argument: _color
        ["Test_Setting_4", "COLOR",    ["-test color-",    "-tooltip-"], "My Category", [1, 1, 0]] call CBA_fnc_addSetting;

        // EDITBOX --- extra argument: default value
        ["Test_Setting_5", "EDITBOX",  ["-test editbox-", "-tooltip-"], "My Category", "defaultValue"] call CBA_fnc_addSetting;

        // TIME PICKER (time in seconds) --- extra arguments: [_min, _max, _default]
        ["Test_Setting_6", "TIME",     ["-test time-",    "-tooltip-"], "My Category", [0, 3600, 60]] call CBA_fnc_addSetting;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

// Prep functions if not yet prepped to avoid race condition.
if (isNil QFUNC(init)) then {
    #include "XEH_PREP.hpp"
};

call FUNC(init) == 0
