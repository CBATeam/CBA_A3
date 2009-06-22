#include "script_component.hpp"

// Simply a package which requires other addons.
class CfgPatches
{
	class ADDON
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = { "Extended_EventHandlers", "cba_main_common", "cba_main_arrays", "cba_main_diagnostic", "cba_main_events", "cba_main_hashes", "cba_main_network", "cba_main_strings" };
		version = VERSION;
	};
};
