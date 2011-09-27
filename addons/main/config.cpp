#include "script_component.hpp"

// Simply a package which requires other addons.
class CfgPatches
{
	class ADDON
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = { "Extended_EventHandlers", "CBA_Extended_EventHandlers", "cba_common", "cba_arrays", "cba_hashes", "cba_strings", "cba_events", "cba_diagnostic", "cba_network", "cba_ai", "cba_vectors", "cba_versioning", "cba_ui", "cba_help" };
		versionDesc = "C.B.A.";
		VERSION_CONFIG;
		author[] = {"CBA Team"};
		authorUrl = "http://dev-heaven.net/projects/cca";
	};
};

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
		description = "Bugtracker: http://dev-heaven.net/projects/cca<br />Documentation: http://dev-heaven.net/projects/cca";
	};
};

class CfgSettings
{
	class CBA {
		class Caching
		{
			functions = 1;
		};
		class Versioning
		{
			class PREFIX {
				// CBA requiring CBA_OA, only if A2 is not found
				class dependencies {
					CBA_OA[] = {"cba_oa_main", {0,7,0}, "!isClass(configFile >> 'CfgPatches' >> 'Chernarus')"};
					XEH[] = {"extended_eventhandlers", {3,3,0}, "true"};
				};
			};
		};
		class Registry
		{
			class PREFIX
			{
				removed[] = {};
			};
		};
	};
};

#include "CfgVehicles.hpp"
