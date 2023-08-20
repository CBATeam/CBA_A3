#include "\x\cba\addons\ee\script_component.hpp"
#undef COMPONENT
#define COMPONENT ee_compat_contact

#if __has_include("\a3\Data_F_Contact\config.bin")
#else
#define PATCH_SKIP "Contact DLC"
#endif

#ifdef PATCH_SKIP
CBA_EE_PATCH_NOT_LOADED(ADDON,PATCH_SKIP)
#else
class CfgPatches {
    class ADDON {
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = { "cba_xeh", "A3_Data_F_Contact" };
        skipWhenMissingDependencies = 1;
        author = "$STR_CBA_Author";
        VERSION_CONFIG;
        // this prevents any patched class from requiring XEH
        addonRootClass = "A3_Characters_F";
    };
};
class XEH_CLASS_BASE;

class CfgVehicles {
    class B_W_Soldier_F;
    class B_W_Story_Protagonist_01_F: B_W_Soldier_F {
        XEH_ENABLED;
    };
    class B_W_Story_Major_01_F: B_W_Soldier_F {
        XEH_ENABLED;
    };
    class B_W_Story_Instructor_01_F: B_W_Soldier_F {
        XEH_ENABLED;
    };
    class B_W_Story_Soldier_01_F: B_W_Soldier_F {
        XEH_ENABLED;
    };
    class B_W_Story_Leader_01_F: B_W_Soldier_F {
        XEH_ENABLED;
    };

    class Logic;
    class VirtualAISquad: Logic {
        XEH_ENABLED;
    };

    class Thing;
    class Particle_Base_F: Thing {
        XEH_ENABLED;
    };

    class Alien_Extractor_01_base_F;
    class Alien_Extractor_01_generic_base_F: Alien_Extractor_01_base_F {
        XEH_ENABLED;
    };

    class ThingX;
    class Alien_MatterBall_01_base_F: ThingX {
        XEH_ENABLED;
    };
    class Alien_MatterBall_01_falling_F: Alien_MatterBall_01_base_F {
        XEH_ENABLED;
    };
};

#endif
