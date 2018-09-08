#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.sqf"

//#define DEBUG_MODE_FULL
#ifdef DEBUG_MODE_FULL
    private _fnc_sanitizeValue = {
        params ["_value"];

        _value = toArray _value;
        _value = _value - toArray "0123456789"; // remove all numbers
        toString _value
    };

    ["Test_Setting_0", "CHECKBOX", ["-test checkbox-", "-tooltip-"], "My Category", true] call cba_settings_fnc_init;
    ["Test_Setting_1", "EDITBOX",  ["-test editbox-",  "-tooltip-"], "My Category", ["null", false, _fnc_sanitizeValue]] call cba_settings_fnc_init;
    ["Test_Setting_2", "LIST",     ["-test list-",     "-tooltip-"], "My Category", [[1, 0], [["enabled", "tooltip 1"], ["disabled", "tooltip 2"]], 1]] call cba_settings_fnc_init;
    ["Test_Setting_3", "SLIDER",   ["-test slider-",   "-tooltip-"], "My Category", [0, 10, 5, 0]] call cba_settings_fnc_init;
    ["Test_Setting_4", "COLOR",    ["-test color-",    "-tooltip-"], "My Category", [1, 1 ,0], false, {diag_log text format ["Color Setting Changed: %1", _this];}] call cba_settings_fnc_init;
    ["Test_Setting_5", "COLOR",    ["-test alpha-",    "-tooltip-"], "My Category", [1, 0, 0, 0.5], false] call cba_settings_fnc_init;
    ["Test_Setting_6", "TIME",     ["-test time-",     "-tooltip-"], "My Category", [0, 3600, 60], false] call cba_settings_fnc_init;
    ["Test_Padding", "LIST", "Padding test", "My Category", [[0,1,2,3,4,5,6,7,8,9,10], []]] call cba_settings_fnc_init;

    ["Test_1", "EDITBOX", "setting 1", "Test Category", "null", nil, {systemChat str [1, _this]}] call cba_settings_fnc_init;
    ["Test_2", "EDITBOX", "setting 2", ["Test Category", "Evens"], "null", nil, {systemChat str [2, _this]}] call cba_settings_fnc_init;
    ["Test_3", "EDITBOX", "setting 3", "Test Category", "null", nil, {systemChat str [3, _this]}] call cba_settings_fnc_init;
    ["Test_4", "EDITBOX", "setting 4", ["Test Category", "Evens"], "null", nil, {systemChat str [4, _this]}] call cba_settings_fnc_init;
    ["Test_5", "EDITBOX", "setting 5", "Test Category", "null",   1, {systemChat str [5, _this]}] call cba_settings_fnc_init;
    ["Test_6", "EDITBOX", "setting 6", ["Test Category", "Evens"], "null",   2, {systemChat str [6, _this]}] call cba_settings_fnc_init;
    ["Test_7", "EDITBOX", "setting 7", ["Test Category", "Seven"], "null",   2, {systemChat str [7, _this]}] call cba_settings_fnc_init;

    ["Test_A", "EDITBOX", "setting 1", "Test Category 1", "a", nil, {systemChat str [1, _this]}] call cba_settings_fnc_init;
    ["Test_B", "EDITBOX", "setting 2", "Test Category 1", "b", nil, {systemChat str [2, _this]}] call cba_settings_fnc_init;
    ["Test_C", "EDITBOX", "setting 3", "Test Category 3", "c", nil, {systemChat str [3, _this]}] call cba_settings_fnc_init;
    ["Test_D", "EDITBOX", "setting 4", "Test Category 3", "d", nil, {systemChat str [4, _this]}] call cba_settings_fnc_init;
#endif

// --- init settings namespaces
#include "initSettings.sqf"

// --- event to refresh missionNamespace value if setting has changed and call public event as well as execute setting script
[QGVAR(refreshSetting), {
    params ["_setting"];
    private _value = _setting call FUNC(get);

    missionNamespace setVariable [_setting, _value];

    if (isNil QGVAR(ready)) exitWith {};

    private _script = (GVAR(default) getVariable [_setting, []]) param [8, {}];
    [_value, _script, _setting] call {
        private ["_setting", "_value", "_script"]; // prevent these variables from being overwritten
        private _thisSetting = _this select 2;
        (_this select 0) call (_this select 1);
    };

    ["CBA_SettingChanged", [_setting, _value]] call CBA_fnc_localEvent;
}] call CBA_fnc_addEventHandler;

// --- event to refresh all settings at once - saves bandwith
[QGVAR(refreshAllSettings), {
    {
        [QGVAR(refreshSetting), _x] call CBA_fnc_localEvent;
    } forEach GVAR(allSettings);
}] call CBA_fnc_addEventHandler;

// refresh all settings when loading a save game
addMissionEventHandler ["Loaded", {
    QGVAR(refreshAllSettings) call CBA_fnc_localEvent;
}];

#ifdef DEBUG_MODE_FULL
    ["CBA_SettingChanged", {
        params ["_setting", "_value"];

        private _message = format ["%1 = %2", _setting, _value];
        systemChat _message;
        //LOG(_message);
    }] call CBA_fnc_addEventHandler;
#endif

// --- event to modify settings on a dedicated server as admin
if (isServer) then {
    [QGVAR(setSettingServer), {
        params ["_setting", "_value", ["_priority", 0], ["_store", false]];

        [_setting, _value, _priority, "server", _store] call FUNC(set);
    }] call CBA_fnc_addEventHandler;
};

// --- event to modify mission settings
[QGVAR(setSettingMission), {
    params ["_setting", "_value", ["_priority", 0], ["_store", false]];

    private _settingType = (GVAR(default) getVariable [_setting, []]) param [2, ""];
    if ((_settingType == "CHECKBOX") && {_value isEqualType 0}) then { _value = _value > 0; };
    [_setting, _value, _priority, "mission", _store] call FUNC(set);
}] call CBA_fnc_addEventHandler;

[[LLSTRING(menu_button), LLSTRING(menu_button_tooltip)], QGVAR(MainMenuHelper)] call CBA_fnc_addPauseMenuOption;

private _ctrlAddonOptions = (uiNamespace getVariable "RscDisplayMain") displayCtrl IDC_MAIN_ADDONOPTIONS;

_ctrlAddonOptions ctrlEnable true;
_ctrlAddonOptions ctrlSetTooltip LLSTRING(menu_button_tooltip);

ADDON = true;
