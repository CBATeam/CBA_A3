#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        units[] = {};
        weapons[] = {};
        requiredAddons[] = {"A3_Data_F","A3_Characters_F","A3_Air_F","A3_Armor_F","A3_Boat_F","A3_Soft_F"};
        requiredVersion = 0.1;
        version = "4.0.0"; // Due to older mod versions requiring > 3,3,3 etc
        versionStr = "4.0.0";
        versionAr[] = {4,0,0};
        author = "$STR_CBA_Author";
        authors[] = {"Solus","Killswitch","commy2"};
        authorUrl = "https://github.com/CBATeam/CBA_A3";
    };

    // Backwards compatibility
    class cba_xeh_a3: ADDON { author = ""; };
    class Extended_EventHandlers: ADDON { author = ""; };
    class CBA_Extended_EventHandlers: ADDON { author = ""; };
    class cba_ee: ADDON { author = ""; };
};

#include "CfgEventHandlers.hpp"
#include "CfgFunctions.hpp"

#include "CfgVehicles.hpp"
