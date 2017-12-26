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
    private _fileExists = false;

    if (!isNull _display) then {
        private _control = _display ctrlCreate ["RscHTML", -1];
        _control htmlLoad _file;
        _fileExists = ctrlHTMLLoaded _control;
        ctrlDelete _control;
    } else {
        _fileExists = loadFile _file != "";
    };

    if (_fileExists) then {
        INFO_1("Userconfig: Loading file [%1]",_file);
        _userconfig = preprocessFile _file;
    } else {
        INFO_1("Userconfig: Could not open file [%1]",_file);
    };
} else {
    INFO("Userconfig: Ignored");
};

uiNamespace setVariable [QGVAR(userconfig), compileFinal str _userconfig];
