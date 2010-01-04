#include "script_component.hpp"

// Simply a package which requires other addons.
class CfgPatches
{
	class ADDON
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = { "Extended_EventHandlers", "CBA_common", "CBA_arrays", "CBA_diagnostic", "CBA_events", "CBA_hashes", "CBA_network", "CBA_strings", "CBA_vectors", "CBA_versioning" };
		version = VERSION;
		versionstr = QUOTE(VERSION);
	};
};

VERSIONING

#include "CfgVehicles.hpp"
