/* ----------------------------------------------------------------------------
Function: CBA_settings_fnc_init

Description:
    Creates a new setting for that session.

Parameters:
    _setting     - Unique setting name. Matches resulting variable name <STRING>
    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    _category    - Category for the settings menu <STRING>
    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    _script      - Script to execute when setting is changed. (optional) <CODE>

Returns:
    _return - Error code <NUMBER>
        0: Success, no error
        1: Failure, error

Examples:
    (begin example)
        // CHECKBOX --- extra argument: default value
        ["Test_Setting_1", "CHECKBOX", ["-test checkbox-", "-tooltip-"], "My Category", true] call cba_settings_fnc_init;

        // LIST --- extra arguments: [_values, _valueTitles, _defaultIndex]
        ["Test_Setting_2", "LIST",     ["-test list-",     "-tooltip-"], "My Category", [[1, 0], ["enabled","disabled"], 1]] call cba_settings_fnc_init;

        // SLIDER --- extra arguments: [_min, _max, _default, _trailingDecimals]
        ["Test_Setting_3", "SLIDER",   ["-test slider-",   "-tooltip-"], "My Category", [0, 10, 5, 0]] call cba_settings_fnc_init;

        // COLOR PICKER --- extra argument: _color
        ["Test_Setting_4", "COLOR",    ["-test color-",    "-tooltip-"], "My Category", [1, 1, 0]] call cba_settings_fnc_init;

        // EDITBOX --- extra argument: default value
        ["Test_Setting_5", "EDITBOX", ["-test editbox-", "-tooltip-"], "My Category", "defaultValue"] call cba_settings_fnc_init;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

// prevent race conditions. function could be called from scheduled env.
if (canSuspend) exitWith {
    [FUNC(init), _this] call CBA_fnc_directCall;
};

// --- init settings system, makes this function useable in preInit without having to add "CBA_settings" to requiredAddons
#include "initSettings.sqf"

params [
    ["_setting", "", [""]],
    ["_settingType", "", [""]],
    ["_title", [], ["", []]],
    ["_category", "", [""]],
    ["_valueInfo", []],
    ["_isGlobal", false, [false, 0]],
    ["_script", {}, [{}]]
];

if (_setting isEqualTo "") exitWith {
    WARNING("Empty setting name");
    1
};

if (_category isEqualTo "") exitWith {
    WARNING_1("Empty menu category for setting %1",_setting);
    1
};

// --- setting title and tooltip
_title params [["_displayName", "", [""]], ["_tooltip", "", [""]]];

if (_displayName isEqualTo "") then {
    _displayName = _setting;
};

// --- who can edit the setting
_isGlobal = [0, 1, 2] select _isGlobal;

// --- setting possible values and default ("data")
private "_defaultValue";
private _settingData = [];

switch (toUpper _settingType) do {
    case "CHECKBOX": {
        _defaultValue = _valueInfo param [0, false, [false]]; // don't use params - we want these variables to be private to the main scope
    };
    case "EDITBOX": {
        _valueInfo params [["_default", "", [""]], ["_isPassword", false, [false]], ["_fnc_sanitizeValue", {_this}, [{}]]];
        _defaultValue = _default; // don't use params - we want these variables to be private to the main scope
        _settingData append [_isPassword, _fnc_sanitizeValue];
    };
    case "LIST": {
        _valueInfo params [["_values", [], [[]]], ["_labels", [], [[]]], ["_defaultIndex", 0, [0]]];

        if (_values isEqualTo []) then {
            {
                _values pushBack _forEachIndex;
            } forEach _labels;
        };

        _labels resize count _values;
        private _tooltips = [];

        {
            if (isNil "_x") then {
                _x = _values select _forEachIndex;
            };

            _x params ["_label", ["_tooltip", ""]];

            if !(_label isEqualType "") then {
                _label = str _label;
            };

            if !(_tooltip isEqualType "") then {
                _tooltip = str _tooltip;
            };

            _labels set [_forEachIndex, _label];
            _tooltips pushBack _tooltip;
        } forEach _labels;

        _defaultValue = _values param [_defaultIndex];
        _settingData append [_values, _labels, _tooltips];
    };
    case "SLIDER": {
        _valueInfo params [["_min", 0, [0]], ["_max", 1, [0]], ["_default", 0, [0]], ["_trailingDecimals", 2, [0]]];

        _defaultValue = _default;
        _settingData append [_min, _max, _trailingDecimals];
    };
    case "COLOR": {
        _defaultValue = [_valueInfo] param [0, [1, 1, 1], [[]], [3,4]];
    };
    default {/* _defaultValue undefined, exit below */};
};

if (isNil "_defaultValue") exitWith {
    WARNING_1("Wrong type for setting %1 (couldn't find default value)",_setting);
    1
};

// --- add setting info to settings namespace
if (isNil {GVAR(default) getVariable _setting}) then {
    GVAR(allSettings) pushBack _setting;
};

GVAR(default) setVariable [_setting, [_defaultValue, _setting, _settingType, _settingData, _category, _displayName, _tooltip, _isGlobal, _script]];

// --- read previous setting values from profile
private _settingInfo = GVAR(userconfig) getVariable _setting;

if (isNil "_settingInfo") then {
    private _settingsHash = profileNamespace getVariable [QGVAR(hash), HASH_NULL];
    _settingInfo = [_settingsHash, toLower _setting] call CBA_fnc_hashGet;
};

if (!isNil "_settingInfo") then {
    _settingInfo params ["_value", "_priority"];

    if !([_setting, _value] call FUNC(check)) then {
        WARNING_2("Invalid value %1 for setting %2. Fall back to default value.",TO_STRING(_value),_setting);
        _value = [_setting, "default"] call FUNC(get);
    };

    // convert boolean to number
    _priority = [0, 1, 2] select _priority;

    GVAR(client) setVariable [_setting, [_value, _priority]];

    if (isServer) then {
        GVAR(server) setVariable [_setting, [_value, _priority], true];
    };
};

// --- read previous setting values from mission
_settingInfo = GVAR(missionConfig) getVariable _setting;

if (isNil "_settingInfo") then {
    private _settingsHash = getMissionConfigValue [QGVAR(hash), HASH_NULL];
    _settingInfo = [_settingsHash, toLower _setting] call CBA_fnc_hashGet;
};

if (!isNil "_settingInfo") then {
    _settingInfo params ["_value", "_priority"];

    // convert boolean to number
    _priority = [0, 1, 2] select _priority;

    if ([_setting, _value] call FUNC(check)) then {
        GVAR(mission) setVariable [_setting, [_value, _priority]];
    } else {
        WARNING_2("Value %1 is invalid for setting %2.",TO_STRING(_value),_setting);
    };
};

// --- refresh
if (isServer) then {
    [QGVAR(refreshSetting), _setting] call CBA_fnc_globalEvent;
} else {
    [QGVAR(refreshSetting), _setting] call CBA_fnc_localEvent;
};

0
