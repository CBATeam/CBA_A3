#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = ECSTRING(main,component);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_main"};
        author = "$STR_CBA_Author";
        authors[] = {};
        url = "$STR_CBA_URL";
        VERSION_CONFIG;
    };
};

#include "CfgMods.hpp"
#include "CfgSettings.hpp"
