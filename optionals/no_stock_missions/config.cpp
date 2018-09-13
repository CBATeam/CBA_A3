#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = CSTRING(component);
        url = "$STR_CBA_URL";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_no_stock_missions_prep"};
        version = VERSION;
        authors[] = {"commy2"};
    };
};

class CfgMissions {
    class MPMissions {};
};
