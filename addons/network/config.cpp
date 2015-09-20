#include "script_component.hpp"
class CfgPatches
{
    class ADDON
    {
        units[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = { "CBA_XEH", "CBA_common", "CBA_events" };
        version = VERSION;
        author[] = {"Sickboy"};
        authorUrl = "https://github.com/CBATeam/CBA_A3";
    };
};
#include "CfgEventhandlers.hpp"
#include "CfgFunctions.hpp"


