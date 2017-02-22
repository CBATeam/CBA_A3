#include "script_component.hpp"

class CfgPatches {
     class ADDON {
        author = "$STR_CBA_Author";
        name = CSTRING(component);
        url = "$STR_CBA_URL";
        units[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"CBA_common"};
        version = VERSION;
        authors[] = {"Fishy"};
    };
};

#include "CfgFunctions.hpp"
#include "CfgMusic.hpp"
