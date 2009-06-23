#include "script_component.hpp"
class CfgPatches
{
	class ADDON
	{
		units[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = { "Extended_EventHandlers", "cba_main_common" };
		version = VERSION;
	};
};
#include "CfgEventhandlers.hpp"
#include "CfgFunctionDeclarations.hpp"
