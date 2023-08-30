#include "\x\cba\addons\xeh\script_component.hpp"
#undef COMPONENT
#define COMPONENT xeh_compat_sog

#if __has_include("\vn\weapons_f_vietnam\config.bin")
#else
#define PATCH_SKIP "SOG-Vietnam"
#endif

#ifdef PATCH_SKIP
CBA_XEH_PATCH_NOT_LOADED(ADDON,PATCH_SKIP)
#else
class CfgPatches {
    class ADDON {
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = { "cba_xeh", "loadorder_f_vietnam" };
        skipWhenMissingDependencies = 1;
        author = "$STR_CBA_Author";
        VERSION_CONFIG;
        // this prevents any patched class from requiring XEH
        addonRootClass = "A3_Characters_F";
    };
};
class XEH_CLASS_BASE;

class CfgVehicles {
    class vn_object_b_base_02;
    class Land_vn_candle_01: vn_object_b_base_02 {
        XEH_ENABLED;
    };

    class Snake_random_F;
    class vn_krait: Snake_random_F {
        XEH_ENABLED;
    };

    class ParachuteBase;
    class vn_parachute_base: ParachuteBase {
        XEH_ENABLED;
    };

    class vn_parachute_02_base: ParachuteBase {};
    class vn_b_parachute_02: vn_parachute_02_base {};
    class vn_b_parachute_02_blu82: vn_b_parachute_02 {};
    class vn_b_parachute_02_blu82_airdrop: vn_b_parachute_02_blu82 {
        XEH_ENABLED;
    };

    class PlaneWreck;
    class vn_o_static_rsna75_wreck: PlaneWreck {
        XEH_ENABLED;
    };
};

#endif
