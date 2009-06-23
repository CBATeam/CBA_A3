#include "script_component.hpp"
class CfgPatches
{
	class ADDON
	{
		units[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = { "Extended_EventHandlers", "CBA_common" };
		version = VERSION;
	};
};
#include "CfgEventhandlers.hpp"
#include "CfgFunctionDeclarations.hpp"
