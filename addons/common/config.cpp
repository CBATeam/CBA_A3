#include "script_component.hpp"
class CfgPatches
{
	class ADDON
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = { "Extended_EventHandlers" };
		version = VERSION;
		author[] = {"Spooner", "Sickboy", "Rocko"};
		authorUrl = URL;
	};
};
#include "CfgEventHandlers.hpp"

#include "CfgFunctions.hpp"
