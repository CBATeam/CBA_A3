#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = CSTRING(component);
        url = "$STR_CBA_URL";
        units[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_common", "cba_events"};
        version = VERSION;
        authors[] = {"Spooner", "Sickboy"};
    };
};

#include "CfgFunctions.hpp"
#include "CfgEventHandlers.hpp"
#include "Cfg3DEN.hpp"
#include "CfgDisplay3DEN.hpp"
#include "gui.hpp"
