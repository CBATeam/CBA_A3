#include "script_component.hpp"

ADDON = false;

// frame after preInit, but before postInit
0 spawn {
    {
        // Do nothing if auto loaded settings file is present
        if (isClass (configFile >> "CfgPatches" >> "cba_auto_load_settings_file")) exitWith {};

        if ([PATH_SETTINGS_FILE_PBO] call EFUNC(settings,readFile)) then {
            LOG("Settings file loaded from PBO.");
        } else {
            WARNING("Settings file not loaded from PBO. File empty or does not exist.");
        };
    } call CBA_fnc_directCall;
};

ADDON = true;
