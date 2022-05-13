#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = "Community Base Addons - Loadout Framework"
        units[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_common", "cba_events"};
        author = "$STR_CBA_Author";
        authors[] = {"Brett Mayson"};
        url = "$STR_CBA_URL";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgFunctions.hpp"
