#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = CSTRING(component);
        units[] = {
            "CBA_B_InvisibleTarget","CBA_O_InvisibleTarget","CBA_I_InvisibleTarget",
            "CBA_B_InvisibleVehicleTarget", "CBA_O_InvisibleVehicleTarget", "CBA_I_InvisibleVehicleTarget",
            "CBA_B_InvisibleAirTarget", "CBA_O_InvisibleAirTarget", "CBA_I_InvisibleAirTarget",
            "CBA_BuildingPos"
        };
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_common"};
        author = "$STR_CBA_Author";
        authors[] = {"Rommel"};
        url = "$STR_CBA_URL";
        VERSION_CONFIG;
    };
};

#include "CfgFunctions.hpp"
#include "CfgVehicles.hpp"
#include "CfgVehicleIcons.hpp"
#include "CfgWaypoints.hpp"
#include "CfgAddons.hpp"
