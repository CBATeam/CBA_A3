#include "script_component.hpp"
class CfgPatches
{
	class ADDON
	{
		units[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = { "CBA_common", "Extended_EventHandlers" };
		version = VERSION;
	};
};
#include "CfgEventHandlers.hpp"
#include "CfgFunctions.hpp"
