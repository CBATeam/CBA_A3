#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = CSTRING(component);
        url = "$STR_CBA_URL";
        units[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = { "CBA_common", "CBA_events" };
        version = VERSION;
        authors[] = {"Sickboy"};
    };
};

class CfgSettings {
    class CBA {
        class COMPONENT {
            disableGlobalExecute = 0;
        };
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgFunctions.hpp"
