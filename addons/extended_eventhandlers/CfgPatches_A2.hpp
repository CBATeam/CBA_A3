class CfgPatches
{
	class Extended_EventHandlers
	{
		units[] = {};
		requiredVersion = 1.00;
		SLX_XEH2_Version = 2.06;
		author[] = {"Solus", "Killswitch", "Sickboy"};
		authorUrl = "http://dev-heaven.net/projects/cca";
		requiredAddons[] =
		{
			"CAAir2", // Car, SU25Wreck, Mi24Wreck, F35bWreck, MQ9PredatorWreck, MV22Wreck, C130JWreck, Ka52Wreck, UH1YWreck
			"CA_E", // Tank
			"CAAir", // Helicopter, ParachuteBase, AH1ZWreck, MH60Wreck, AV8BWreck, Mi17Wreck
			"CAA10", // Plane, A10, A10Wreck
			"CAData", // Ship, StaticCannon
			"HALO_Test", // BIS_Steerable_Parachute
			"CA_Modules", // BIS_Effect_FilmGrain, BIS_Effect_Day, BIS_Effect_MovieNight, BIS_Effect_Sepia
			"CA_Missions_AlternativeInjurySimulation", // AlternativeInjurySimulation
			"CA_Modules_Alice", // AliceManager
			"CA_Missions_AmbientCombat", // AmbientCombatManager
			"CA_Modules_Animals", // BIS_animals_Logic
			"CA_Missions_BattlefieldClearance", // BattleFieldClearance
			"CA_Modules_clouds", // BIS_clouds_Logic
			"CA_Modules_Coin", // ConstructionManager
			"CA_Missions_FirstAidSystem", // FirstAidSystem
			"CA_Modules_Functions", // FunctionsManager, PreloadManager
			"CA_Missions_GarbageCollector", // GarbageCollector
			"CA_HighCommand", // HighCommand, HighCommandSubordinate
			"CA_Modules_Marta", // MartaManager
			"CA_Modules_Silvie", // SilvieManager
			"BI_SRRS", // BIS_SRRS_Logic
			"CA_Modules_UAV", // UAVManager
			"CA_Modules_ZoRA", // ZoraManager
			"CA_Animals2_Chicken", // CAAnimalBase
			"CA_Modules_ARTY", // M252, 2b14_82mm, BIS_ARTY_Logic, BIS_ARTY_Virtual_Artillery
			"CA_Missions_SecOps", // SecOpManager
			"CA_Modules_StratLayer", // StrategicReferenceLayer
			"CACharacters2", // FR_Base, FR_Miles, FR_Cooper, FR_Sykes, FR_OHara, FR_Rodriguez
			"CAMisc3", // Land_Fire_burning, Land_Campfire_burning, Land_Fire_barrel_burning, FlagCarrierUSA, FlagCarrierCDF, FlagCarrierRU, FlagCarrierINS, FlagCarrierGUE, FlagCarrierChecked, TargetPopUpTarget, TargetEpopup, Barrack2, Mass_grave, Warfare
			"CATracked2_AAV", // AAV
			"CAAir3", // Su34
			"CA_CruiseMissile" // CruiseMissile2
		};
	};
};

// Disabled preLoadAddons; These are not required since XEH only overrides the
// existing class tree, instead of extend or relink. If preloadAddons is
// disabled, you should receive a message about missing XEH addon, ONLY when
// the requiredAddons list is incomplete, or class inheritance is broken
/*
class CfgAddons
{
	class PreloadAddons
	{
		class Extended_EventHandlers
		{
			list[] = { "Extended_EventHandlers" };
		};
	 };
};
*/
