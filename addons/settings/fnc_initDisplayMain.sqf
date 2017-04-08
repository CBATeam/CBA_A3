#include "script_component.hpp"

// --- load userconfig file
params ["_display"];

private _file = "";

if (isClass (configFile >> "CfgPatches" >> QGVAR(userconfig))) then {
    _file = USERCONFIG_SETTINGS_FILE_ADDON;
} else {
    if (isFilePatchingEnabled) then {
        _file = USERCONFIG_SETTINGS_FILE;
    };
};

private _userconfig = "";

if (_file != "") then {
    INFO("Loading userconfig file ...");
    private _fileExists = false;

    if (!isNull _display) then {
        private _control = _display ctrlCreate ["RscHTML", -1];
        _control htmlLoad USERCONFIG_SETTINGS_FILE;
        _fileExists = ctrlHTMLLoaded _control;
        ctrlDelete _control;
    } else {
        _fileExists = loadFile USERCONFIG_SETTINGS_FILE != "";
    };

    if (_fileExists) then {
        _userconfig = preprocessFile USERCONFIG_SETTINGS_FILE;
    };
};

uiNamespace setVariable [QGVAR(userconfig), compileFinal str _userconfig];
