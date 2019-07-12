#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = CSTRING(component);
        url = "$STR_CBA_URL";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"A3_Data_F_Enoch_Loadorder", "A3_Data_F_Mod_Loadorder"};
        version = VERSION;
        authors[] = {"Spooner","Sickboy","Rocko"};
    };
};

#include "Cfg3DEN.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgFunctions.hpp"

#include "CfgVehicles.hpp"
#include "CfgLocationTypes.hpp"
#include "CfgWeapons.hpp"
