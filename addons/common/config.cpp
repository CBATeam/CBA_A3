#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = CSTRING(component);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"A3_Data_F_AoW_Loadorder", "A3_Data_F_Mod_Loadorder"};
        author = "$STR_CBA_Author";
        authors[] = {"Spooner","Sickboy","Rocko"};
        url = "$STR_CBA_URL";
        VERSION_CONFIG;
    };
};

#include "Cfg3DEN.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgFunctions.hpp"

#include "CfgVehicles.hpp"
#include "CfgLocationTypes.hpp"
#include "CfgWeapons.hpp"
