#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = ECSTRING(jam,component);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "cba_jam",
            "weapons_v_f_vietnam_c"
        };
        author = "$STR_CBA_Author";
        authors[] = {};
        url = "$STR_CBA_URL";
        skipWhenMissingDependencies = 1;
        VERSION_CONFIG;
    };
};
