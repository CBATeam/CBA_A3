#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = ECSTRING(Optional,Component);
        url = "$STR_CBA_URL";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_jr"};
        version = VERSION;
        authors[] = {"Robalo"};
    };
};

class asdg_OpticRail1913;

class asdg_OpticRail1913_short: asdg_OpticRail1913 {
    class compatibleItems;
};

class asdg_OpticRail1913_short_MG: asdg_OpticRail1913_short {
    class compatibleItems: compatibleItems {
        optic_SOS = 0;
        optic_SOS_khk_F = 0;
        optic_DMS = 0;
        optic_DMS_ghex_F = 0;
        optic_LRPS = 0;
        optic_LRPS_ghex_F = 0;
        optic_LRPS_tna_F = 0;
        optic_AMS = 0;
        optic_AMS_khk = 0;
        optic_AMS_snd = 0;
        optic_KHS_blk = 0;
        optic_KHS_hex = 0;
        optic_KHS_old = 0;
        optic_KHS_tan = 0;
    };
};
