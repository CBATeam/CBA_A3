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
    if (FILE_EXISTS(_file)) then {
        INFO_1("Userconfig: File [%1] loaded successfully.",_file);
        _userconfig = _file;
    } else {
        INFO_1("Userconfig: File [%1] not found or empty.",_file);
    };
} else {
    INFO("Userconfig: Ignored.");
};

uiNamespace setVariable [QGVAR(userconfig), compileFinal str _userconfig];

private _volatile = getNumber (configFile >> QGVAR(volatile)) == 1;
uiNamespace setVariable [QGVAR(volatile), _volatile];
if (_volatile) then {
    WARNING("Server settings changes will be lost upon game restart.");
};

private _ctrlAddonOptions = _display displayCtrl IDC_MAIN_ADDONOPTIONS;

if (isNil QUOTE(ADDON)) then {
    _ctrlAddonOptions ctrlEnable false;
    _ctrlAddonOptions ctrlSetTooltip LELSTRING(common,need_mission_start);
};
