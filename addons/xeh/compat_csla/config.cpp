#include "\x\cba\addons\xeh\script_component.hpp"
#undef COMPONENT
#define COMPONENT xeh_compat_csla

class CfgPatches {
    class ADDON {
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = { "cba_xeh", "CSLA", "US85" };
        skipWhenMissingDependencies = 1;
        author = "$STR_CBA_Author";
        VERSION_CONFIG;
        // this prevents any patched class from requiring XEH
        addonRootClass = "A3_Characters_F";
    };
};
class XEH_CLASS_BASE;

class CfgVehicles {
    class StaticATWeapon;
    class CSLA_9K113_Stat: StaticATWeapon {
        XEH_ENABLED;
    };

    class Mortar_01_base_F;
    class CSLA_M52_Stat: Mortar_01_base_F {
        XEH_ENABLED;
    };

    class PlaneWreck;
    class CSLA_CIV_AN2_wreck: PlaneWreck {
        XEH_ENABLED;
    };

    class Plane_Base_F;
    class CSLA_Plane_base_F: Plane_Base_F {};
    class CSLA_CIV_Plane_base_F: CSLA_Plane_base_F {};
    class CSLA_CIV_Plane_base: CSLA_CIV_Plane_base_F {
        XEH_ENABLED;
    };

    class StaticMGWeapon;
    class CSLA_UK59L_Stat: StaticMGWeapon {
        XEH_ENABLED;
    };

    class CSLA_UK59T_Stat: StaticMGWeapon {
        XEH_ENABLED;
    };

    class US85_M252_Stat: Mortar_01_base_F {
        XEH_ENABLED;
    };
};
