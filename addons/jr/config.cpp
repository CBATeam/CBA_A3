#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = CSTRING(component);
        url = "$STR_CBA_URL";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_jr_prep"};
        version = VERSION;
        authors[] = {"Robalo"};
    };
};

#include "jr_classes.hpp"
#include "cfgweapons.hpp"
#include "CfgFunctions.hpp"
