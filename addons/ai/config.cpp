#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = CSTRING(component);
        url = "$STR_CBA_URL";
        units[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_common"};
        version = VERSION;
        authors[] = {"Rommel"};
    };
};

#include "CfgFunctions.hpp"
#include "CfgVehicles.hpp"
#include "CfgVehicleIcons.hpp"
#include "CfgWaypoints.hpp"
