#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = CSTRING(component);
        url = "$STR_CBA_URL";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"CBA_common", "A3_UI_F", "3DEN"};
        version = VERSION;
        authors[] = {"commy2"};
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgFunctions.hpp"

#include "Cfg3DEN.hpp"
#include "Display3DEN.hpp"

#include "gui.hpp"
