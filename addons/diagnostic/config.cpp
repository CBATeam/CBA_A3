#include "script_component.hpp"
class CfgPatches
{
	class ADDON
	{
		units[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = { "CBA_common", "CBA_events" };
		version = VERSION;
		author[] = {"Spooner", "Sickboy"};
		authorUrl = URL;
	};
};

#include "CfgFunctions.hpp"
#include "CfgEventhandlers.hpp"
