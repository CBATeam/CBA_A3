#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = CSTRING(component);
        url = "$STR_CBA_URL";
        units[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"CBA_common", "A3_UI_F"};
        version = VERSION;
        authors[] = {"Taosenai"};
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgFunctions.hpp"

#include "gui\gui.hpp"
