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
    };

    // --- read userconfig file
    GVAR(userconfig) = [] call CBA_fnc_createNamespace;

    if (isNil QGVAR(serverConfig)) then {
        GVAR(serverConfig) = NAMESPACE_NULL;
    };

    if (isServer) then {
        missionNamespace setVariable [QGVAR(serverConfig), true call CBA_fnc_createNamespace, true];
    };

    private _userconfig = call (uiNamespace getVariable QGVAR(userconfig));

    {
        _x params ["_setting", "_value", "_priority"];

        GVAR(userconfig) setVariable [_setting, [_value, _priority]];

        if (isServer) then {
            GVAR(serverConfig) setVariable [_setting, true, true];
        };
    } forEach ([_userconfig, false] call FUNC(parse));

    // --- read mission settings file
    GVAR(missionConfig) = [] call CBA_fnc_createNamespace;

    private _missionConfig = "";

    if (getMissionConfigValue [QGVAR(hasSettingsFile), false] in [true, 1]) then {
        INFO("Loading mission settings file ...");
        _missionConfig = preprocessFile MISSION_SETTINGS_FILE;
    };

    {
        _x params ["_setting", "_value", "_priority"];

        GVAR(missionConfig) setVariable [_setting, [_value, _priority]];
    } forEach ([_missionConfig, false] call FUNC(parse));
};
