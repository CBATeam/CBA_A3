#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = CSTRING(component);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_common"};
        author = "$STR_CBA_Author";
        authors[] = {"Solus", "Killswitch", "commy2"};
        url = "$STR_CBA_URL";
        VERSION_CONFIG;

        // this prevents any patched class from requiring XEH
        addonRootClass = "A3_Characters_F";
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgFunctions.hpp"
#include "CfgVehicles.hpp"
