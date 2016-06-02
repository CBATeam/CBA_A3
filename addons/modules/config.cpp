#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        units[] = {"CBA_ModuleAttack","CBA_ModuleDefend","CBA_ModulePatrol"};
        requiredVersion = 0.1;
        requiredAddons[] = {"A3_Modules_F"};
        author = "$STR_CBA_Author";
        authors[] = {"WiredTiger"};
        authorUrl = "";
    };
};

#include "CfgFactionClasses.hpp"
#include "CfgVehicles.hpp"
#include "CfgFunctions.hpp"
