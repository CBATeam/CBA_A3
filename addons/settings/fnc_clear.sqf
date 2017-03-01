/* ----------------------------------------------------------------------------
Internal Function: CBA_settings_fnc_clear

Description:
    Clear all settings from profile or mission.

Parameters:
    _source  - Can be "client", "mission" or "server" (optional, default: "client") <STRING>

Returns:
    None

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [["_source", "client", [""]]];

switch (toLower _source) do {
    case "client": {
        profileNamespace setVariable [QGVAR(hash), NULL_HASH];
        GVAR(clientSettings) call CBA_fnc_deleteNamespace;
        GVAR(clientSettings) = [] call CBA_fnc_createNamespace;
    };
    case "mission": {
        if (!is3DEN) exitWith {};

        set3DENMissionAttributes [["Scenario", QGVAR(hash), NULL_HASH]];
        GVAR(missionSettings) call CBA_fnc_deleteNamespace;
        GVAR(missionSettings) = [] call CBA_fnc_createNamespace;
    };
    case "server": {
        if (!isServer) exitWith {};

        profileNamespace setVariable [QGVAR(hash), NULL_HASH];
        GVAR(serverSettings) call CBA_fnc_deleteNamespace;
        GVAR(serverSettings) = isMultiplayer call CBA_fnc_createNamespace;
        publicVariable QGVAR(serverSettings);
    };
    default {};
};

if (isServer) then {
    QGVAR(refreshAllSettings) call CBA_fnc_globalEvent;
} else {
    QGVAR(refreshAllSettings) call CBA_fnc_localEvent;
};

nil
