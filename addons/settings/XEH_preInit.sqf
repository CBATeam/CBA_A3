//#define DEBUG_MODE_FULL
#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.sqf"

#ifdef DEBUG_MODE_FULL
// CHECKBOX --- extra argument: default value
["Test_Setting_1", "CHECKBOX", ["-test checkbox-", "-tooltip-"], "My Category", true] call cba_settings_fnc_init;
["Test_Setting_2", "LIST",     ["-test list-",     "-tooltip-"], "My Category", [[1,0], ["enabled","disabled"], 1]] call cba_settings_fnc_init;
["Test_Setting_3", "SLIDER",   ["-test slider-",   "-tooltip-"], "My Category", [0, 10, 5, 0]] call cba_settings_fnc_init;
["Test_Setting_4", "COLOR",    ["-test color-",    "-tooltip-"], "My Category", [1,1,0]] call cba_settings_fnc_init;
#endif

// --- init settings namespaces
#include "initSettings.sqf"

// --- event to refresh missionNamespace value if setting has changed and call public event as well as execute setting script
[QGVAR(refreshSetting), {
    params ["_setting"];
    private _value = _setting call FUNC(get);

    missionNamespace setVariable [_setting, _value];

    if (isNil QGVAR(ready)) exitWith {};

    private _script = [GVAR(defaultSettings) getVariable _setting] param [0, []] param [8, {}];
    [_script, _value] call {
        private ["_setting", "_value", "_script"]; // prevent these variables from being overwritten
        _this call CBA_fnc_directCall;
    };

    ["CBA_SettingChanged", [_setting, _value]] call CBA_fnc_localEvent;
}] call CBA_fnc_addEventHandler;

// event to refresh all settings at once - saves bandwith
[QGVAR(refreshAllSettings), {
    {
        [QGVAR(refreshSetting), _x] call CBA_fnc_localEvent;
    } forEach GVAR(allSettings);
}] call CBA_fnc_addEventHandler;

#ifdef DEBUG_MODE_FULL
["CBA_SettingChanged", {
    params ["_setting", "_value"];

    private _message = format ["[CBA] (settings): %1 = %2", _setting, _value];
    systemChat _message;
    diag_log text _message;
}] call CBA_fnc_addEventHandler;
#endif

// event to modify settings on a dedicated server as admin
if (isServer) then {
    [QGVAR(setSettingServer), {
        params ["_setting", "_value", "_forced"];
        [_setting, _value, _forced, "server"] call FUNC(set);
    }] call CBA_fnc_addEventHandler;
};

// import settings from file if filepatching is enabled
if (isFilePatchingEnabled) then {
    [loadFile PATH_SETTINGS_FILE, "client"] call FUNC(import);
    diag_log text "[CBA] (settings): Settings file loaded.";
} else {
    diag_log text "[CBA] (settings): Cannot load settings file. File patching disabled. Use -filePatching flag.";
};

ADDON = true;
