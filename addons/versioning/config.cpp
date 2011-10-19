#include "script_component.hpp"
class CfgPatches
{
	class ADDON
	{
		units[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = { "CBA_common", "CBA_strings", "CBA_hashes", "CBA_diagnostic", "CBA_events", "CBA_network", "Extended_EventHandlers" };
		version = VERSION;
		author[] = {"Sickboy"};
		authorUrl = "http://dev-heaven.net/projects/cca";
	};
};
#include "CfgEventHandlers.hpp"

