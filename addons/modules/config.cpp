#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = CSTRING(component);
        url = "$STR_CBA_URL";
        units[] = {"CBA_ModuleAttack", "CBA_ModuleDefend", "CBA_ModulePatrol"};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"A3_Modules_F", "CBA_common"};
        version = VERSION;
        authors[] = {"WiredTiger"};

    };
};

#include "CfgFactionClasses.hpp"
#include "CfgVehicles.hpp"
#include "CfgFunctions.hpp"
