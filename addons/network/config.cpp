#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = CSTRING(component);
        url = "$STR_CBA_URL";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"CBA_common", "CBA_events"};
        version = VERSION;
        authors[] = {"Sickboy"};
    };
};

#include "CfgFunctions.hpp"

#include "CfgSettings.hpp"
