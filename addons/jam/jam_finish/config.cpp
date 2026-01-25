#include "script_component.hpp"

class CfgPatches {
    class SUBADDON {
        name = CSTRING(component);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_jam"};
        author = "$STR_CBA_Author";
        authors[] = {};
        url = "$STR_CBA_URL";
        VERSION_CONFIG;
    };
};

#include "CfgWeapons.hpp"
