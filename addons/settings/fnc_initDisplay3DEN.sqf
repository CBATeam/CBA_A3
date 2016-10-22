#include "script_component.hpp"

private _fnc_resetMissionSettings = {
    // --- initialize settings of new mission
    #include "initMissionSettings.sqf"
};

add3DENEventHandler ["onMissionNew", _fnc_resetMissionSettings];
add3DENEventHandler ["onMissionLoad", _fnc_resetMissionSettings];

private _fnc_checkMissionSettingsFile = {
    INFO("Loading mission settings file ...");

    private _control = findDisplay 313 ctrlCreate ["RscHTML", -1];
    _control htmlLoad MISSION_SETTINGS_FILE;

    private _fileExists = ctrlHTMLLoaded _control;
    ctrlDelete _control;

    set3DENMissionAttributes [["Scenario", QGVAR(hasSettingsFile), _fileExists]];
};

add3DENEventHandler ["onMissionLoad", _fnc_checkMissionSettingsFile];
add3DENEventHandler ["onMissionSaveAs", _fnc_checkMissionSettingsFile];
