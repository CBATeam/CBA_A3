#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = CSTRING(component);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_common", "cba_events"};
        author = "$STR_CBA_Author";
        authors[] = {"da12thMonkey", "Robalo", "Tupolov"};
        url = "$STR_CBA_URL";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgFunctions.hpp"
