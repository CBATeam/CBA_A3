#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = CSTRING(component);
        url = "$STR_CBA_URL";
        units[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = { "CBA_common", "CBA_strings", "CBA_hashes", "CBA_diagnostic", "CBA_events", "CBA_network" };
        version = VERSION;
        authors[] = {"Sickboy"};
    };
};

#include "CfgEventHandlers.hpp"
