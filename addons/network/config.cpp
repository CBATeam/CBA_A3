#include "script_component.hpp"
class CfgPatches
{
	class ADDON
	{
		units[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = { "Extended_EventHandlers", "cba_main" };
		version = VERSION;
	};
};
#include "CfgEventHandlers.hpp"