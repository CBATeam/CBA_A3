#include "script_component.hpp"

class CfgPatches {
    class SUBADDON {
        name = CSTRING(component);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_xeh", "loadorder_f_vietnam"};
        skipWhenMissingDependencies = 1;
        author = "$STR_CBA_Author";
        authors[] = {"Dahlgren"};
        url = "$STR_CBA_URL";
        VERSION_CONFIG;

        // this prevents any patched class from requiring XEH
        addonRootClass = "A3_Characters_F";
    };
};

class XEH_CLASS_BASE;

#include "CfgVehicles.hpp"
