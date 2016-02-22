#include "script_component.hpp"
class CfgPatches
{
    class ADDON
    {
        units[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = { "CBA_common", "CBA_events" };
        version = VERSION;
        author[] = {"Sickboy"};
        authorUrl = "https://github.com/CBATeam/CBA_A3";
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
