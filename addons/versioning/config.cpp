#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = CSTRING(component);
        url = "$STR_CBA_URL";
        units[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_common", "cba_strings", "cba_hashes", "cba_diagnostic", "cba_events", "cba_network"};
        version = VERSION;
        authors[] = {"Sickboy"};
    };
};

#include "CfgEventHandlers.hpp"
