class CfgPatches
{
	class Extended_EventHandlers
	{
		units[] = {};
		requiredVersion = REQUIRED_VERSION;
		SLX_XEH2_Version = VERSION_SCALAR;
		version = VERSION;
		versionStr = QUOTE(VERSION);
		versionAr[] = {VERSION_AR};
		author[] = {"Solus", "Killswitch", "Sickboy"};
		authorUrl = "http://dev-heaven.net/projects/cca";
		requiredAddons[] =
		{
			"hsim_data_h",
			"hsim_air_h"
			//"CAData", // All, Car, Tank, Helicopter, Plane, Ship, ParachuteBase
			//"CA_Missions_AmbientCombat", // AmbientCombatManager
			//"CA_Modules_Functions", // FunctionsManager, PreloadManager
			//"CA_Missions_GarbageCollector" // GarbageCollector
		};
	};
	class CBA_Extended_EventHandlers { units[] = {}; weapons[] = {}; requiredVersion = REQUIRED_VERSION; requiredAddons[] = {}; };
};

// Disabled preLoadAddons; These are not required since XEH only overrides the
// existing class tree, instead of extend or relink. If preloadAddons is
// disabled, you should receive a message about missing XEH addon, ONLY when
// the requiredAddons list is incomplete, or class inheritance is broken
/*
PRELOAD_ADDONS;
*/
