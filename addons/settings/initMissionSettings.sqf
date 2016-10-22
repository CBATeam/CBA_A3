// inline function, don't include script_component.hpp

// --- load mission config file
private _missionConfig = "";

if (getMissionConfigValue [QGVAR(hasSettingsFile), false]) then {
    INFO("Loading mission settings file ...");
    _missionConfig = loadFile MISSION_SETTINGS_FILE;
};

// --- read mission config settings
GVAR(missionConfig) call CBA_fnc_deleteNamespace;
GVAR(missionConfig) = [] call CBA_fnc_createNamespace;

{
    _x params ["_setting", "_value", "_priority"];

    GVAR(missionConfig) setVariable [_setting, [_value, _priority min 1]];
} forEach ([_missionConfig, false] call FUNC(parse));

// delay a frame, because 3den attributes are unavailable at frame 0
// cannot use CBA_fnc_execNextFrame, because we need this to run before postInit
addMissionEventHandler ["EachFrame", {
    GVAR(mission) call CBA_fnc_deleteNamespace;
    GVAR(mission) = [] call CBA_fnc_createNamespace;

    // --- read previous setting values from mission
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

    // --- refresh all settings now
    QGVAR(refreshAllSettings) call CBA_fnc_localEvent;

    removeMissionEventHandler ["EachFrame", _thisEventHandler];
}];
