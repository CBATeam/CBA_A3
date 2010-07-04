#include "script_component.hpp"

// Simply a package which requires other addons.
class CfgPatches
{
	class ADDON
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = { "Extended_EventHandlers", "cba_common", "cba_arrays", "cba_hashes", "cba_strings", "cba_events", "cba_diagnostic", "cba_network", "cba_ai", "cba_vectors", "cba_versioning", "cba_ui", "cba_help" };
		VERSION_CONFIG;
		author[] = {"CBA Team"};
		authorUrl = "http://dev-heaven.net/projects/cca";
	};
};

VERSIONING

class CfgMods
{
	class PREFIX
	{
		dir = "@CBA";
		name = "Community Base Addons";
		picture = "ca\ui\data\logo_arma2ep1_ca.paa";
		hidePicture = "true";
		hideName = "true";
		actionName = "Website";
		action = "http://dev-heaven.net/projects/cca";
	};
};
#include "CfgVehicles.hpp"
