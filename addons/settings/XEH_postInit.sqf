#include "script_component.hpp"

// --- refresh all settings after postInit to guarantee that events are added and settings are recieved from server
{
    if (isNil QGVAR(server)) then {
        ERROR("No server settings after postInit phase.");
    };

    //Event to read modules
    ["CBA_beforeSettingsInitialized", []] call CBA_fnc_localEvent;

    // --- refresh all settings now
    GVAR(ready) = true; // enable setting init script and CBA_SettingChanged event
    QGVAR(refreshAllSettings) call CBA_fnc_localEvent;

    LOG("Settings Initialized");
    ["CBA_settingsInitialized", []] call CBA_fnc_localEvent;
} call CBA_fnc_execNextFrame;

// --- autosave mission and server presets
private _presetsHash = profileNamespace getVariable [QGVAR(presetsHash), HASH_NULL];
private _autosavedPresets = profileNamespace getVariable [QGVAR(autosavedPresets), [[],[]]];

if !(allVariables GVAR(mission) isEqualTo []) then {
    private _preset = "mission" call FUNC(export);
    private _presetName = format ["Autosave: %1 (%2)", localize LSTRING(ButtonMission), missionName];

    [_presetsHash, _presetName, _preset] call CBA_fnc_hashSet;

    (_autosavedPresets select 0) pushBackUnique _presetName;

    if (count (_autosavedPresets select 0) > 3) then {
        private _presetToRemove = (_autosavedPresets select 0) deleteAt 0;
        [_presetsHash, _presetToRemove] call CBA_fnc_hashRem;
    };
};

if (serverName != "") then {
    private _preset = "server" call FUNC(export);
    private _presetName = format ["Autosave: %1 (%2)", localize LSTRING(ButtonServer), serverName];

    [_presetsHash, _presetName, _preset] call CBA_fnc_hashSet;

    (_autosavedPresets select 1) pushBackUnique _presetName;

    if (count (_autosavedPresets select 1) > 3) then {
        private _presetToRemove = (_autosavedPresets select 1) deleteAt 0;
        [_presetsHash, _presetToRemove] call CBA_fnc_hashRem;
    };
};

profileNamespace setVariable [QGVAR(presetsHash), _presetsHash];
profileNamespace setVariable [QGVAR(autosavedPresets), _autosavedPresets];
