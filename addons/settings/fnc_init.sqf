/* ----------------------------------------------------------------------------
Function: CBA_settings_fnc_init

Description:
    Creates a new setting for that session.

Parameters:
    _setting     - Unique setting name. Matches resulting variable name <STRING>
    _settingType - Type of setting. Can be "CHECKBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    _category    - Category for the settings menu <STRING>
    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
    _isGlobal    - true: all clients share the same state of the setting (optional, default: false) <ARRAY>
    _script      - Script to execute when setting is changed or forced. (optional) <CODE>

Returns:
    _return - Error code <NUMBER>
        0: Success, no error
        1: Empty setting name
        2: Empty menu category
        3: Wrong setting type (couldn't find correct default value)

Examples:
    (begin example)
        // CHECKBOX --- extra argument: default value
        ["Test_Setting_1", "CHECKBOX", ["-test checkbox-", "-tooltip-"], "My Category", true] call cba_settings_fnc_init;

        // LIST --- extra arguments: [_values, _valueTitles, _defaultIndex]
        ["Test_Setting_2", "LIST",     ["-test list-",     "-tooltip-"], "My Category", [[1,0], ["enabled","disabled"], 1]] call cba_settings_fnc_init;

        // SLIDER --- extra arguments: [_min, _max, _default, _trailingDecimals]
        ["Test_Setting_3", "SLIDER",   ["-test slider-",   "-tooltip-"], "My Category", [0, 10, 5, 0]] call cba_settings_fnc_init;

        // COLOR PICKER --- extra argument: _color
        ["Test_Setting_4", "COLOR",    ["-test color-",    "-tooltip-"], "My Category", [1,1,0]] call cba_settings_fnc_init;
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
    ["_isGlobal", false, [false]],
    ["_script", {}, [{}]]
];

if (_setting isEqualTo "") exitWith {1};
if (_category isEqualTo "") exitWith {2};

// --- setting title and tooltip
_title params [["_displayName", "", [""]], ["_tooltip", "", [""]]];

if (_displayName isEqualTo "") then {
    _displayName = _setting;
};

// --- setting possible values and default ("data")
private "_defaultValue";
private _settingData = [];

switch (toUpper _settingType) do {
    case ("CHECKBOX"): {
        _defaultValue = _valueInfo param [0, false, [false]]; // don't use params - we want these variables to be private to the main scope
    };
    case ("LIST"): {
        _valueInfo params [["_values", [], [[]]], ["_labels", [], [[]]], ["_defaultIndex", 0, [0]]];

        if (_values isEqualTo []) then {
            {
                _values pushBack _forEachIndex;
            } forEach _labels;
        };

        _labels resize count _values;

        {
            if (isNil "_x") then {
                _x = _values select _forEachIndex;
            };

            if !(_x isEqualType "") then {
                _x = str _x;
            };

            _labels set [_forEachIndex, _x];
        } forEach _labels;

        _defaultValue = _values param [_defaultIndex];
        _settingData append [_values, _labels];
    };
    case ("SLIDER"): {
        _valueInfo params [["_min", 0, [0]], ["_max", 1, [0]], ["_default", 0, [0]], ["_trailingDecimals", 2, [0]]];

        _defaultValue = _default;
        _settingData append [_min, _max, _trailingDecimals];
    };
    case ("COLOR"): {
        _defaultValue = [_valueInfo] param [0, [1,1,1], [[]], [3,4]];
    };
    default {/* _defaultValue undefined, exit below */};
};

if (isNil "_defaultValue") exitWith {3};

// --- add setting info to settings namespace
GVAR(defaultSettings) setVariable [_setting, [_defaultValue, _setting, _settingType, _settingData, _category, _displayName, _tooltip, _isGlobal, _script]];
GVAR(allSettings) pushBackUnique _setting;

// --- read previous setting values from profile
private _settingsHash = profileNamespace getVariable [QGVAR(hash), NULL_HASH];
private _settingInfo = [_settingsHash, toLower _setting] call CBA_fnc_hashGet;

if (!isNil "_settingInfo") then {
    _settingInfo params ["_value", "_forced"];

    if !([_setting, _value] call FUNC(check)) then {
        _value = [_setting, "default"] call FUNC(get);
        [_setting, _value, _forced, "client"] call FUNC(set);
        WARNING_1("Invalid value for setting %1. Fall back to default value.",str _setting);
    };

    GVAR(clientSettings) setVariable [_setting, [_value, _forced]];

    if (isServer && isMultiplayer) then {
        GVAR(serverSettings) setVariable [_setting, [_value, _forced], true];
    };
};

// --- read previous setting values from mission
_settingsHash = getMissionConfigValue QGVAR(hash);

if (isNil "_settingsHash") then {
    _settingsHash = NULL_HASH;
};

_settingInfo = [_settingsHash, toLower _setting] call CBA_fnc_hashGet;

if (!isNil "_settingInfo") then {
    _settingInfo params ["_value", "_forced"];

    if ([_setting, _value] call FUNC(check)) then {
        GVAR(missionSettings) setVariable [_setting, [_value, _forced]];
    };
};

// --- refresh
if (isServer) then {
    [QGVAR(refreshSetting), _setting] call CBA_fnc_globalEvent;
} else {
    [QGVAR(refreshSetting), _setting] call CBA_fnc_localEvent;
};

0
