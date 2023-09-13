#include "script_component.hpp"

class CfgPatches {
    class SUBADDON {
        author = "$STR_CBA_Author";
        name = CSTRING(component);
        url = "$STR_CBA_URL";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_jr"};
        version = VERSION;
    };
};

#include "CfgWeapons.hpp"
