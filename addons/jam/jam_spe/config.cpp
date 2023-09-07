#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = ECSTRING(jam,component);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "cba_jam",
            "WW2_SPE_Core_c_ZZZ_LastLoaded_c"
        };
        author = "$STR_CBA_Author";
        authors[] = {};
        url = "$STR_CBA_URL";
        skipWhenMissingDependencies = 1;
        VERSION_CONFIG;
    };
};

#include "CfgMagazineWells.hpp"
#include "CfgWeapons.hpp"
