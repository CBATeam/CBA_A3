#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = CSTRING(component);
        url = "$STR_CBA_URL";
        units[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"CBA_common","CBA_events","3DEN"};
        version = VERSION;
        authors[] = {"Spooner","Sickboy"};
    };
};

#include "CfgFunctions.hpp"
#include "CfgEventHandlers.hpp"

#include "CfgDisplay3DEN.hpp"
