#include "\x\cba\addons\xeh\script_component.hpp"
#undef COMPONENT
#define COMPONENT xeh_compat_spe

class CfgPatches {
    class ADDON {
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = { "cba_xeh", "WW2_SPE_Assets_c_Vehicles_ZZZ_LastLoaded_c" };
        skipWhenMissingDependencies = 1;
        author = "$STR_CBA_Author";
        VERSION_CONFIG;
        // this prevents any patched class from requiring XEH
        addonRootClass = "A3_Characters_F";
    };
};
class XEH_CLASS_BASE;

class CfgVehicles {
    class Tank;
    class SPE_Armored_Target_Dummy: Tank {
        class EventHandlers {
            // This class has an empty CBA_Extended_EventHandlers, repopulate with actual event handlers
            class CBA_Extended_EventHandlers {
                EXTENDED_EVENTHANDLERS
            };
        };
        SLX_XEH_DISABLED = 0;
    };
    class ModuleEmpty_F;
    class SPE_MineObject_base: ModuleEmpty_F {
        XEH_ENABLED;
    };
    class SPE_Minefield_base: SPE_MineObject_base {};
    class SPE_MINE_TMI42_Field_30x30: SPE_Minefield_base {
        XEH_ENABLED;
    };
    class SPE_MINE_TMI42_Field_70x30: SPE_Minefield_base {
        XEH_ENABLED;
    };
    class SPE_MINE_US_M1A1_ATMINE_Field_30x30: SPE_Minefield_base {
        XEH_ENABLED;
    };
};
