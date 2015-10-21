#include "script_component.hpp"

class CfgPatches
{
    class ADDON
    {
        units[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"CBA_common", "CBA_events"};
        version = VERSION;
        author[] = {"commy2"};
        authorUrl = "https://github.com/commy2/";
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgFunctions.hpp"
