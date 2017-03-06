#include "script_component.hpp"

ADDON = false;

// frame after preInit, but before postInit
0 spawn {
    {
        if (isFilePatchingEnabled) then {
            if ([PATH_SETTINGS_FILE] call EFUNC(settings,readFile)) then {
                LOG("Settings file loaded.");
            } else {
                WARNING("Settings file not loaded. File empty or does not exist.");
            };
        } else {
            WARNING("Cannot load settings file. File patching disabled. Use -filePatching flag.");
        };
    } call CBA_fnc_directCall;
};

ADDON = true;
