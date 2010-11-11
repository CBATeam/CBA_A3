class CfgPatches
{
	class Extended_EventHandlers
	{
		units[] = {};
		requiredVersion = 1.05;
		SLX_XEH2_Version = VERSION_SCALAR;
		version = VERSION;
		versionStr = QUOTE(VERSION);
		versionAr[] = {VERSION_AR};
		author[] = {"Solus", "Killswitch", "Sickboy"};
		authorUrl = "http://dev-heaven.net/projects/cca";
		requiredAddons[] =
		{
			"CAData", // All, Car, Tank, Helicopter, Plane, Ship, ParachuteBase, StaticCannon
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
			"CA_Modules_Alice2", // Alice2Manager
			"CA_Modules_E_Gita", // GitaManager
			"CA_Modules_E_Jukebox", // JukeboxManager
			"CA_Support", // BIS_Support
			"CA_Modules_E_UAV_Heli", // UAV_HeliManager
			"CA_Modules_E_Weather", // WeatherPostprocessManager, WeatherParticlesManager
			"CA_Animals2_Chicken", // CAAnimalBase
			"CA_Modules_ARTY", // M252, 2b14_82mm, BIS_ARTY_Logic, BIS_ARTY_Virtual_Artillery
			"CA_Missions_SecOps", // SecOpManager
			"CA_Modules_StratLayer", // StrategicReferenceLayer
			"Warfare2_E", // WarfareOA
			"CACharacters2", // FR_Miles, FR_Cooper, FR_Sykes, FR_OHara, FR_Rodriguez
			"CACharacters_E", // TK_CIV_Takistani01_EP1, TK_CIV_Takistani02_EP1, TK_CIV_Takistani03_EP1, TK_CIV_Takistani04_EP1, TK_CIV_Takistani05_EP1, TK_CIV_Takistani06_EP1, TK_CIV_Woman01_EP1, TK_CIV_Woman02_EP1, TK_CIV_Woman03_EP1, Dr_Annie_Baker_EP1, Rita_Ensler_EP1, Haris_Press_EP1, Dr_Hladik_EP1, TK_INS_Soldier_EP1, TK_INS_Soldier_2_EP1, TK_INS_Soldier_3_EP1, TK_INS_Soldier_4_EP1, TK_INS_Soldier_AA_EP1, TK_INS_Soldier_AT_EP1, TK_INS_Soldier_TL_EP1, TK_INS_Soldier_Sniper_EP1, TK_INS_Soldier_AR_EP1, TK_INS_Soldier_MG_EP1, TK_INS_Bonesetter_EP1, TK_INS_Warlord_EP1, TK_GUE_Soldier_EP1, TK_GUE_Soldier_2_EP1, TK_GUE_Soldier_3_EP1, TK_GUE_Soldier_4_EP1, TK_GUE_Soldier_5_EP1, TK_GUE_Soldier_AA_EP1, TK_GUE_Soldier_AT_EP1, TK_GUE_Soldier_HAT_EP1, TK_GUE_Soldier_TL_EP1, TK_GUE_Soldier_Sniper_EP1, TK_GUE_Soldier_AR_EP1, TK_GUE_Soldier_MG_EP1, TK_GUE_Bonesetter_EP1, TK_GUE_Warlord_EP1
			"CAAir", // AH1ZWreck, MH60Wreck, AV8BWreck, Mi17Wreck
			"CAMisc3", // Land_Fire_burning, Land_Campfire_burning, Land_Fire_barrel_burning, FlagCarrierUSA, FlagCarrierCDF, FlagCarrierRU, FlagCarrierINS, FlagCarrierGUE, FlagCarrierChecked, TargetPopUpTarget, TargetEpopup, Barrack2, Mass_grave, Warfare
			"CATracked2_AAV", // AAV
			"CAWheeled_E", // Pickup_PK_TK_GUE_EP1
			"CAA10", // A10, A10Wreck
			"CAAir2", // SU25Wreck, Mi24Wreck, F35bWreck, MQ9PredatorWreck, MV22Wreck, C130JWreck, Ka52Wreck, UH1YWreck
			"CAAir3", // Su34
			"CAAir_E_AH6J", // AH6X_EP1
			"CAAir_E_Halo", // Steerable_Parachute_EP1
			"CA_L39", // l39Wreck
			"CAMisc_E", // FlagCarrierUNO_EP1, FlagCarrierRedCrystal_EP1, FlagCarrierTFKnight_EP1, FlagCarrierCDFEnsign_EP1, FlagCarrierRedCross_EP1, FlagCarrierUSArmy_EP1, FlagCarrierTKMilitia_EP1, FlagCarrierRedCrescent_EP1, FlagCarrierGermany_EP1, FlagCarrierNATO_EP1, FlagCarrierBIS_EP1, FlagCarrierCzechRepublic_EP1, FlagCarrierPOWMIA_EP1, FlagCarrierBLUFOR_EP1, FlagCarrierOPFOR_EP1, FlagCarrierINDFOR_EP1, FlagCarrierTakistan_EP1, FlagCarrierTakistanKingdom_EP1, FlagCarrierUSA_EP1, FlagCarrierCDF_EP1, FlagCarrierWhite_EP1
			"CA_CruiseMissile" // CruiseMissile2
		};
	};
};

// Disabled preLoadAddons; These are not required since XEH only overrides the
// existing class tree, instead of extend or relink. If preloadAddons is
// disabled, you should receive a message about missing XEH addon, ONLY when
// the requiredAddons list is incomplete, or class inheritance is broken
/*
PRELOAD_ADDONS;
*/
