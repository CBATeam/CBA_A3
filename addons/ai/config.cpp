#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = CSTRING(component);
        units[] = {
            "CBA_B_InvisibleTarget","CBA_O_InvisibleTarget","CBA_I_InvisibleTarget",
            "CBA_B_InvisibleTargetVehicle","CBA_O_InvisibleTargetVehicle","CBA_I_InvisibleTargetVehicle",
            "CBA_B_InvisibleTargetAir","CBA_O_InvisibleTargetAir","CBA_I_InvisibleTargetAir",
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
