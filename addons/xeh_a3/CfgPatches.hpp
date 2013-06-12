class CfgPatches {
	class ADDON {
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {
			"CBA_a3_Main", "CBA_XEH",
			"CAData", "A3_Characters_F", "A3_Boat_F", "A3_animals_f", "A3_air_f", "A3_soft_f", "A3_static_f", "A3_weapons_f", "a3_structures_f" // "A3_armor_f"
			//"CAData", // All, Car, Tank, Helicopter, Plane, Ship, ParachuteBase
			//"CA_Missions_AmbientCombat", // AmbientCombatManager
			//"CA_Modules_Functions", // FunctionsManager, PreloadManager
			//"CA_Missions_GarbageCollector" // GarbageCollector
		};
		VERSION_CONFIG;
		author[] = {"CBA Team"};
		authorUrl = "http://dev-heaven.net/projects/cca";
	};
};
