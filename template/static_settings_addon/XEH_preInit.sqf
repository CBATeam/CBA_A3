#include "script_component.hpp"

ADDON = false;

// frame after preInit, but before postInit
0 spawn {
    {
        #include "loadSettingsFile.sqf"
    } call CBA_fnc_directCall;
};

ADDON = true;
