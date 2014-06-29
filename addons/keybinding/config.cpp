#include "script_component.hpp"
class CfgPatches
{
	class ADDON
	{
		units[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = { "CBA_common", "CBA_XEH", "A3_UI_F" };
		version = VERSION;
		author[] = {"Taosenai"};
		authorUrl = "http://dev-heaven.net/projects/cca";
	};
};

#include "CfgEventHandlers.hpp"
#include "CfgFunctions.hpp"

#include "gui\gui.hpp"


