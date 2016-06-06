#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = ECSTRING(Optional,Component);
        url = "$STR_CBA_URL";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_common","cba_events","cba_hashes","cba_jr","cba_xeh"};
        version = VERSION;
        authors[] = {"commy2"};
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgFunctions.hpp"
