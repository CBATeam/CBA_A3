#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = CSTRING(component);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_jr_prep"};
        author = "$STR_CBA_Author";
        authors[] = {"Robalo"};
        url = "$STR_CBA_URL";
        VERSION_CONFIG;
    };
};

#include "jr_classes.hpp"
#include "CfgWeapons.hpp"
#include "CfgFunctions.hpp"
