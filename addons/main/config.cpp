#include "script_component.hpp"

// Simply a package which requires other addons.
class CfgPatches
{
	class ADDON
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = { "Extended_EventHandlers", "cba_common", "cba_arrays", "cba_events", "cba_diagnostic", "cba_hashes", "cba_network", "cba_strings", "cba_vectors", "cba_versioning", "cba_ai" };
		VERSION_CONFIG;
	};
};

VERSIONING

#include "CfgVehicles.hpp"
