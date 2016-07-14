#include "script_component.hpp"

private _fnc_resetMissionSettings = {
    // --- delete settings from previous mission
    GVAR(missionSettings) call CBA_fnc_deleteNamespace;
    GVAR(missionSettings) = [] call CBA_fnc_createNamespace;

    GVAR(hash) = nil;

    // --- initialize settings of new mission
    #include "initMissionSettings.sqf"
};

add3DENEventHandler ["onMissionNew", _fnc_resetMissionSettings];
add3DENEventHandler ["onMissionLoad", _fnc_resetMissionSettings];
