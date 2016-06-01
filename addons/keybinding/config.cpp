#include "script_component.hpp"
class CfgPatches
{
    class ADDON
    {
        units[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = { "CBA_common", "A3_UI_F" };
        version = VERSION;
        author = "$STR_CBA_Author";
        authors[] = {"Taosenai"};
        authorUrl = "https://github.com/CBATeam/CBA_A3";
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgFunctions.hpp"

#include "gui\gui.hpp"


