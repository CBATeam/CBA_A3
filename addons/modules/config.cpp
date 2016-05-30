#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        units[] = {"CBA_ModuleAttack","CBA_ModuleDefend","CBA_ModulePatrol"};
        requiredVersion = 0.1;
        requiredAddons[] = {"A3_Modules_F"};
        //author[] = {"WiredTiger"};
        authorUrl = "https://github.com/CBATeam/CBA_A3";
    };
};

#include "CfgFactionClasses.hpp"
#include "CfgVehicles.hpp"
#include "CfgFunctions.hpp"
