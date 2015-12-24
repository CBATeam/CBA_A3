#include "script_component.hpp"
class CfgPatches
{
    class ADDON
    {
        units[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = { "CBA_common", "CBA_strings", "CBA_hashes", "CBA_diagnostic", "CBA_events", "CBA_network" };
        version = VERSION;
        author[] = {"Sickboy"};
        authorUrl = "https://github.com/CBATeam/CBA_A3";
    };
};
#include "CfgEventHandlers.hpp"


