#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = "Community Base Addons - Pylons";
        units[] = {
            QGVAR(pylon_base)
        };
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_common"};
        author = "$STR_CBA_Author";
        authors[] = {"Ampersand"};
        url = "$STR_CBA_URL";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"
