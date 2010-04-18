#include "script_component.hpp"
class CfgPatches
{
	class ADDON
	{
		units[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = { "Extended_EventHandlers", "CBA_common" };
		version = VERSION;
		author[] = {"Sickboy"};
		authorUrl = URL;
	};
};
#include "CfgEventhandlers.hpp"
#include "CfgFunctions.hpp"
