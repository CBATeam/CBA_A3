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
        authorUrl = "http://dev-heaven.net/projects/cca";
    };
};
#include "CfgEventhandlers.hpp"
#include "CfgFunctions.hpp"


