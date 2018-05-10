#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = CSTRING(component);
        url = "$STR_CBA_URL";
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {"cba_common"};
        requiredVersion = 0.1;
        version = "4.0.0"; // Due to older mod versions requiring > 3,3,3 etc
        versionStr = "4.0.0";
        versionAr[] = {4, 0, 0};
        authors[] = {"Solus", "Killswitch", "commy2"};

        // this prevents any patched class from requiring XEH
        addonRootClass = "A3_Characters_F";
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgFunctions.hpp"
#include "CfgVehicles.hpp"
