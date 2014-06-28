#include "script_component.hpp"
class CfgPatches
{
	class ADDON
	{
		units[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = { "CBA_common", "CBA_XEH" };
		version = VERSION;
		author[] = {"Taosenai"};
		authorUrl = "http://dev-heaven.net/projects/cca";
	};
};

#include "CfgEventHandlers.hpp"
#include "CfgFunctions.hpp"

#include "gui\keybinding_gui.hpp"


