#include "\x\cba\addons\ee\script_component.hpp"
#undef COMPONENT
#define COMPONENT ee_compat_ws

#if __has_include("\lxWS\data_f_lxWS\config.bin")
#else
#define PATCH_SKIP "Western Sahara"
#endif

#ifdef PATCH_SKIP
CBA_EE_PATCH_NOT_LOADED(ADDON,PATCH_SKIP)
#else
class CfgPatches {
    class ADDON {
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = { "cba_xeh", "data_f_lxWS" };
        skipWhenMissingDependencies = 1;
        author = "$STR_CBA_Author";
        VERSION_CONFIG;
        // this prevents any patched class from requiring XEH
        addonRootClass = "A3_Characters_F";
    };
};
class XEH_CLASS_BASE;

class CfgVehicles {
    class PowerLines_Small_base_F;
    class Land_PowerPoleWooden_lxWS: PowerLines_Small_base_F {
        XEH_ENABLED;
    };
    class Land_PowerPoleWooden_L_lxWS: PowerLines_Small_base_F {
        XEH_ENABLED;
    };
    class Land_PowerPoleWooden_L_off_lxWS: PowerLines_Small_base_F {
        XEH_ENABLED;
    };

    class Module_F;
    class Site_Camels_lxWS: Module_F {
        XEH_ENABLED;
    };

    class C_journalist_F;
    class C_Journalist_lxWS: C_journalist_F {
        XEH_ENABLED;
    };
    
    class C_Man_casual_1_F_afro;
    class C_Tak_01_A_lxWS: C_Man_casual_1_F_afro {
        XEH_ENABLED;
    };
    
    class B_Soldier_TL_F;
    class B_ION_Story_Givens_lxWS: B_Soldier_TL_F {
        XEH_ENABLED;
    };

    class B_Soldier_F;
    class I_PMC_Soldier_01_lxWS: B_Soldier_F {
    };
    class I_PMC_Story_Gustavo_lxWS: I_PMC_Soldier_01_lxWS {
        XEH_ENABLED;
    };

    class I_officer_F;
    class I_SFIA_officer_lxWS: I_officer_F {
    };
    class I_SFIA_Said_lxWS: I_SFIA_officer_lxWS {
        XEH_ENABLED;
    };

    class Truck_02_base_F;
    class Truck_02_cargo_base_lxWS: Truck_02_base_F {
        XEH_ENABLED;
    };
    class Truck_02_box_base_lxWS: Truck_02_base_F {
        XEH_ENABLED;
    };
    class Truck_02_Ammo_base_lxWS: Truck_02_base_F {
        XEH_ENABLED;
    };
    class Truck_02_aa_base_lxWS: Truck_02_base_F {
        XEH_ENABLED;
    };
};

#endif
