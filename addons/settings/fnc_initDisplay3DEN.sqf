#include "script_component.hpp"

private _fnc_resetMissionSettings = {
    GVAR(mission) call CBA_fnc_deleteNamespace;
    GVAR(mission) = [] call CBA_fnc_createNamespace;

    // --- read mission settings file
    GVAR(missionConfig) call CBA_fnc_deleteNamespace;
    GVAR(missionConfig) = [] call CBA_fnc_createNamespace;

    private _missionConfig = "";

    if (getMissionConfigValue [QGVAR(hasSettingsFile), false]) then {
        INFO("Loading mission settings file ...");
        _missionConfig = loadFile MISSION_SETTINGS_FILE;
    };

    {
        _x params ["_setting", "_value", "_priority"];

        GVAR(missionConfig) setVariable [_setting, [_value, _priority]];
    } forEach ([_missionConfig, false] call FUNC(parse));

    {
        private _setting = _x;
        private _settingInfo = GVAR(missionConfig) getVariable _setting;

        if (isNil "_settingInfo") then {
            private _settingsHash = getMissionConfigValue [QGVAR(hash), HASH_NULL];
            _settingInfo = [_settingsHash, toLower _setting] call CBA_fnc_hashGet;
        };

        if (!isNil "_settingInfo") then {
            _settingInfo params ["_value", "_priority"];

            // convert boolean to number
            _priority = [0,1,2] select _priority;

            if ([_setting, _value] call FUNC(check)) then {
                GVAR(mission) setVariable [_setting, [_value, _priority]];
            };
        };
    } forEach GVAR(allSettings);

    QGVAR(refreshAllSettings) call CBA_fnc_localEvent;
};

add3DENEventHandler ["OnMissionNew", _fnc_resetMissionSettings];
add3DENEventHandler ["OnMissionLoad", _fnc_resetMissionSettings];

// Missions crash on dedicated servers if there is a file missing during init.
// Thus we check if the mission settings file exists when saving / exporting
// the mission instead and set a flag. The 3den eventhandlers for saving a
// mission fire after the mission was saved, so we have to repeat the action
// after we update the flag.
#define MESSGAE_SAVED 0
#define MESSGAE_AUTOSAVED 1
#define MESSAGE_EXPORTED_SP 5
#define MESSAGE_EXPORTED_MP 6

#define FILE_EXISTS(file) \
call {\
    private _control = findDisplay 313 ctrlCreate ["RscHTML", -1];\
    _control htmlLoad file;\
    private _return = ctrlHTMLLoaded _control;\
    ctrlDelete _control;\
    _return\
};

add3DENEventHandler ["OnMessage", {
    params ["_message"];

    if !(_message in [MESSGAE_SAVED, MESSAGE_EXPORTED_SP, MESSAGE_EXPORTED_MP]) exitWith {};

    INFO("Checking mission settings file ...");
    private _fileExists = FILE_EXISTS(MISSION_SETTINGS_FILE);
    private _fileExistedPreviously = "Scenario" get3DENMissionAttribute QGVAR(hasSettingsFile);

    if !(_fileExists isEqualTo _fileExistedPreviously) then {
        set3DENMissionAttributes [["Scenario", QGVAR(hasSettingsFile), _fileExists]];

        switch (_message) do {
            case MESSGAE_SAVED: {
                do3DENAction "MissionSave";
            };
            case MESSAGE_EXPORTED_SP: {
                do3DENAction "MissionExportSP";
            };
            case MESSAGE_EXPORTED_MP: {
                do3DENAction "MissionExportMP";
            };
        };
    };
}];
