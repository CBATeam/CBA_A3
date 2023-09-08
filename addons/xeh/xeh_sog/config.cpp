#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = ECSTRING(xeh,component);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_xeh", "loadorder_f_vietnam"};
        skipWhenMissingDependencies = 1;
        author = "$STR_CBA_Author";
        authors[] = {"PabstMirror"};
        url = "$STR_CBA_URL";
        VERSION_CONFIG;

        // this prevents any patched class from requiring XEH
        addonRootClass = "A3_Characters_F";
    };
};

#include "CfgVehicles.hpp"
