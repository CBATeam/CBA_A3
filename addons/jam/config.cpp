#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = CSTRING(component);
        url = "$STR_CBA_URL";
        units[] = {};
        weapons[] = {};
        magazines[] = {};
        ammo[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_common"};
        version = VERSION;
        authors[] = {"Robalo"};
    };
};

#include "CfgMagazineWells.hpp"
#include "CfgWeapons.hpp"
