#include "script_component.hpp"

ADDON = false;

// Don't prep functions if already prepped by CBA_fnc_addSetting to avoid log spam.
if (isNil QFUNC(init)) then {
    #include "XEH_PREP.hpp"
};

//#define DEBUG_MODE_FULL
#ifdef DEBUG_MODE_FULL
    private _fnc_sanitizeValue = {
        params ["_value"];

        _value = toArray _value;
        _value = _value - toArray "0123456789"; // remove all numbers
        toString _value
    };

    ["Test_Setting_0", "CHECKBOX", ["-test checkbox-", "-tooltip-"], "My Category", true] call CBA_fnc_addSetting;
    ["Test_Setting_1", "EDITBOX",  ["-test editbox-",  "-tooltip-"], "My CategorY", ["null", false, _fnc_sanitizeValue]] call CBA_fnc_addSetting;
    ["Test_Setting_2", "LIST",     ["-test list-",     "-tooltip-"], "My Category", [[1, 0], [["enabled", "tooltip 1"], ["disabled", "tooltip 2"]], 1]] call CBA_fnc_addSetting;
    ["Test_Setting_3", "SLIDER",   ["-test slider-",   "-tooltip-"], "My Category", [0, 10, 5, 0]] call CBA_fnc_addSetting;
    ["Test_Setting_4", "COLOR",    ["-test color-",    "-tooltip-"], "My Category", [1, 1 ,0], false, {diag_log text format ["Color Setting Changed: %1", _this];}] call CBA_fnc_addSetting;
    ["Test_Setting_5", "COLOR",    ["-test alpha-",    "-tooltip-"], "My Category", [1, 0, 0, 0.5], false] call CBA_fnc_addSetting;
    ["Test_Setting_6", "TIME",     ["-test time-",     "-tooltip-"], "My Category", [0, 3600, 60], false] call CBA_fnc_addSetting;
    ["Test_Setting_7", "SLIDER",   ["-test slider (percentage)- ",   "-tooltip-"], "My Category", [0, 1, 0.5, 0, true]] call CBA_fnc_addSetting;
    ["Test_Padding", "LIST", "Padding test", "My Category", [[0,1,2,3,4,5,6,7,8,9,10], []]] call CBA_fnc_addSetting;

    ["Test_1", "EDITBOX", "setting 1", "Test Category", "null", nil, {systemChat str [1, _this]}] call CBA_fnc_addSetting;
    ["Test_2", "EDITBOX", "setting 2", ["Test Category", "Evens"], "null", nil, {systemChat str [2, _this]}] call CBA_fnc_addSetting;
    ["Test_3", "EDITBOX", "setting 3", "Test Category", "null", nil, {systemChat str [3, _this]}] call CBA_fnc_addSetting;
    ["Test_4", "EDITBOX", "setting 4", ["Test Category", "Evens"], "null", nil, {systemChat str [4, _this]}] call CBA_fnc_addSetting;
    ["Test_5", "EDITBOX", "setting 5", "Test Category", "null",   1, {systemChat str [5, _this]}] call CBA_fnc_addSetting;
    ["Test_6", "EDITBOX", "setting 6", ["Test Category", "Evens"], "null",   2, {systemChat str [6, _this]}] call CBA_fnc_addSetting;
    ["Test_7", "EDITBOX", "setting 7", ["Test Category", "Seven"], "null",   2, {systemChat str [7, _this]}] call CBA_fnc_addSetting;

    ["Test_b1", "CHECKBOX", "setting b1", ["Test йййй"], false, 2, {systemChat str ["b1", _this]}] call CBA_fnc_addSetting;
    ["Test_b2", "CHECKBOX", "setting b2л", ["Test йййй", "ллл"], false, 2, {systemChat str ["b2", _this]}] call CBA_fnc_addSetting;
    ["Test_b3", "CHECKBOX", "setting b3ф", ["Test йййй", "ффф"], true, 2, {systemChat str ["b3", _this]}] call CBA_fnc_addSetting;

    ["Test_c1", "CHECKBOX", "setting c1", ["Test nnnn"], false, 2, {systemChat str ["c1", _this]}] call CBA_fnc_addSetting;
    ["Test_c2", "CHECKBOX", "setting c2r", ["Test nnnn", "rrr"], false, 2, {systemChat str ["c2", _this]}] call CBA_fnc_addSetting;
    ["Test_c3", "CHECKBOX", "setting c3o", ["Test nnnn", "ooo"], true, 2, {systemChat str ["c3", _this]}] call CBA_fnc_addSetting;

    ["Test_A", "EDITBOX", "setting 1", "Test Category 1", "a", nil, {systemChat str [1, _this]}] call CBA_fnc_addSetting;
    ["Test_B", "EDITBOX", "setting 2", "Test Category 1", "b", nil, {systemChat str [2, _this]}] call CBA_fnc_addSetting;
    ["Test_C", "EDITBOX", "setting 3", "Test Category 3", "c", nil, {systemChat str [3, _this]}] call CBA_fnc_addSetting;
    ["Test_D", "EDITBOX", "setting 4", "Test Category 3", "d", nil, {systemChat str [4, _this]}] call CBA_fnc_addSetting;
#endif

// --- init settings namespaces
#include "initSettings.inc.sqf"

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
