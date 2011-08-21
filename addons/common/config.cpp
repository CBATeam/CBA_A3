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
		authorUrl = "http://dev-heaven.net/projects/cca";
	};
};
#include "CfgEventHandlers.hpp"

#include "CfgFunctions.hpp"

#include "CfgPerFrame.hpp"

