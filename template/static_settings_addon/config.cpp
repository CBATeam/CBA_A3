#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = ECSTRING(settings,component);
        url = "$STR_CBA_URL";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_settings"};
        version = VERSION;
        authors[] = {"commy2"};
    };
};

#include "CfgEventHandlers.hpp"
