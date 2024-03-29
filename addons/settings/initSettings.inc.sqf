// inline function, don't include script_component.hpp

if (isNil QGVAR(default)) then {
    GVAR(allSettings) = [];
    GVAR(default) = [] call CBA_fnc_createNamespace;

    // --- main setting sources
    GVAR(client) = [] call CBA_fnc_createNamespace;
    GVAR(mission) = [] call CBA_fnc_createNamespace;

    if (isNil QGVAR(server)) then {
        GVAR(server) = NAMESPACE_NULL;
    };

    if (isServer) then {
        missionNamespace setVariable [QGVAR(server), true call CBA_fnc_createNamespace, true];
        private _volatile = isDedicated && {(getNumber (configFile >> QGVAR(volatile))) == 1};
        missionNamespace setVariable [QGVAR(volatile), _volatile, true];
        if (_volatile) then {WARNING("Server settings changes will be lost upon game restart.")};
    };

    // --- read userconfig file
    GVAR(userconfig) = [] call CBA_fnc_createNamespace;

    if (isNil QGVAR(serverConfig)) then {
        GVAR(serverConfig) = NAMESPACE_NULL;
    };

    if (isServer) then {
        missionNamespace setVariable [QGVAR(serverConfig), true call CBA_fnc_createNamespace, true];
    };

    private _userconfig = preprocessFile call (uiNamespace getVariable QGVAR(userconfig));

    INFO("Reading settings from settings file.");

    {
        _x params ["_setting", "_value", "_priority"];

        #ifdef DEBUG_MODE_FULL
        INFO_3("Setting %1 with value %2 and priority %3 set in userconfig.",_setting,_value,_priority);
        #endif

        GVAR(userconfig) setVariable [_setting, [_value, _priority]];

        if (isServer) then {
            GVAR(serverConfig) setVariable [_setting, true, true];
        };
    } forEach ([_userconfig, false] call FUNC(parse));

    INFO("Finished reading settings from settings file.");

    // --- read mission settings file
    GVAR(missionConfig) = [] call CBA_fnc_createNamespace;

    private _missionConfig = "";

    if (getMissionConfigValue [QGVAR(hasSettingsFile), false] in [true, 1]) then {
        _missionConfig = preprocessFile MISSION_SETTINGS_FILE;

        if (_missionConfig isEqualTo "") then {
            INFO_1("Mission Config: File [%1] not found or empty.",MISSION_SETTINGS_FILE);
        } else {
            INFO_1("Mission Config: File [%1] loaded successfully.",MISSION_SETTINGS_FILE);
        };
    };

    {
        _x params ["_setting", "_value", "_priority"];

        GVAR(missionConfig) setVariable [_setting, [_value, _priority]];
    } forEach ([_missionConfig, false] call FUNC(parse));

    GVAR(needRestart) = [];
    GVAR(awaitingRestart) = [];
};
