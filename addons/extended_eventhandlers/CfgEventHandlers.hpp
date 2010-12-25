// XEH uses all existing event handlers
#define EXTENDED_EVENTHANDLERS init = "if(isnil'SLX_XEH_objects')then{call compile preprocessFile'extended_eventhandlers\InitXEH.sqf'};_this call SLX_XEH_EH_Init"; \
fired = "_this call SLX_XEH_EH_Fired"; \
animChanged      = "_this call SLX_XEH_EH_AnimChanged"; \
animStateChanged = "_this call SLX_XEH_EH_AnimStateChanged"; \
animDone         = "_this call SLX_XEH_EH_AnimDone"; \
dammaged         = "_this call SLX_XEH_EH_Dammaged"; \
engine           = "_this call SLX_XEH_EH_Engine"; \
firedNear        = "_this call SLX_XEH_EH_FiredNear"; \
fuel             = "_this call SLX_XEH_EH_Fuel"; \
gear             = "_this call SLX_XEH_EH_Gear"; \
getIn            = "_this call SLX_XEH_EH_GetIn"; \
getOut           = "_this call SLX_XEH_EH_GetOut"; \
hit              = "_this call SLX_XEH_EH_Hit"; \
incomingMissile  = "_this call SLX_XEH_EH_IncomingMissile"; \
killed           = "_this call SLX_XEH_EH_Killed"; \
landedTouchDown  = "_this call SLX_XEH_EH_LandedTouchDown"; \
landedStopped    = "_this call SLX_XEH_EH_LandedStopped"; \
respawn          = "_this call SLX_XEH_EH_Respawn"; // \
//mpRespawn        = "_this call SLX_XEH_EH_MPRespawn"; \
//mpHit            = "_this call SLX_XEH_EH_MPHit"; \
//mpKilled         = "_this call SLX_XEH_EH_MPKilled"; // \
//handleDamage     = "_this call SLX_XEH_EH_HandleDamage"; \
//handleHealing    = "_this call SLX_XEH_EH_HandleHealing";


// We'll need this one for backwards compatibility with third-party addons
// that expect the class to exist
class Extended_EventHandlers
{
	EXTENDED_EVENTHANDLERS
};

// Class for "pre-init", run-once event handlers. Code in here runs before any
// Extended_Init_Eventhandlers code.
class Extended_PreInit_EventHandlers {};

// The PostInit handlers also run once, but after all the extended init EH:s
// have run and after all mission.sqm "init lines" have been processed.
class Extended_PostInit_EventHandlers {};

// Finally, "InitPost" handlers are run once on every unit in the mission.
// Note the difference here - the PreInit and PostInit handlers above run once
// per mission but InitPost handlers are called for each unit.
class Extended_InitPost_EventHandlers {};

// Extended EH classes, where new events are defined.
class Extended_Init_EventHandlers
{
	// Vehicles.
	class StaticCannon /* : StaticWeapon */ {
		SLX_BIS = "if(isNil 'BIS_Effects_Init') then { call compile preProcessFileLineNumbers ""\ca\Data\ParticleEffects\SCRIPTS\init.sqf""; }";
	};

	class M252 /* : StaticMortar */ {
		SLX_BIS = "if(isNil 'BIS_Effects_Init') then { call compile preProcessFileLineNumbers ""\ca\Data\ParticleEffects\SCRIPTS\init.sqf""; }";
	};
	class 2b14_82mm /* : StaticMortar */ {
		SLX_BIS = "if(isNil 'BIS_Effects_Init') then { call compile preProcessFileLineNumbers ""\ca\Data\ParticleEffects\SCRIPTS\init.sqf""; }";
	};
	class FR_Miles /* : FR_Base */ {
		SLX_BIS = "(_this select 0) setidentity ""Miles""";
	};
	class FR_Cooper /* : FR_GL */ {
		SLX_BIS = "(_this select 0) setidentity ""Cooper""";
	};
	class FR_Sykes /* : FR_Marksman */ {
		SLX_BIS = "(_this select 0) setidentity ""Sykes""";
	};
	class FR_OHara /* : FR_Corpsman */ {
		SLX_BIS = "(_this select 0) setidentity ""Ohara""";
	};
	class FR_Rodriguez /* : FR_AR */ {
		SLX_BIS = "(_this select 0) setidentity ""Rodriguez""";
	};
	class TK_CIV_Takistani01_EP1 /* : TK_CIV_Takistani_Base_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\civil\Tak_civil01\Data\Tak_civil01_1_co.paa"",""\CA\characters_E\civil\Tak_civil01\Data\Tak_civil01_2_co.paa"",""\CA\characters_E\civil\Tak_civil01\Data\Tak_civil01_3_co.paa"",""\CA\characters_E\civil\Tak_civil01\Data\Tak_civil01_4_co.paa"",""\CA\characters_E\civil\Tak_civil01\Data\Tak_civil01_5_co.paa""] select floor random 5]";
	};
	class TK_CIV_Takistani02_EP1 /* : TK_CIV_Takistani_Base_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\civil\Tak_civil02\Data\Tak_civil02_1_co.paa"",""\CA\characters_E\civil\Tak_civil02\Data\Tak_civil02_2_co.paa"",""\CA\characters_E\civil\Tak_civil02\Data\Tak_civil02_3_co.paa"",""\CA\characters_E\civil\Tak_civil02\Data\Tak_civil02_4_co.paa"",""\CA\characters_E\civil\Tak_civil02\Data\Tak_civil02_5_co.paa""] select floor random 5]";
	};
	class TK_CIV_Takistani03_EP1 /* : TK_CIV_Takistani_Base_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\civil\Tak_civil03\Data\Tak_civil03_1_co.paa"",""\CA\characters_E\civil\Tak_civil03\Data\Tak_civil03_2_co.paa"",""\CA\characters_E\civil\Tak_civil03\Data\Tak_civil03_3_co.paa"",""\CA\characters_E\civil\Tak_civil03\Data\Tak_civil03_4_co.paa"",""\CA\characters_E\civil\Tak_civil03\Data\Tak_civil03_5_co.paa""] select floor random 5]";
	};
	class TK_CIV_Takistani04_EP1 /* : TK_CIV_Takistani_Base_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\civil\Tak_civil04\Data\Tak_civil04_1_co.paa"",""\CA\characters_E\civil\Tak_civil04\Data\Tak_civil04_2_co.paa"",""\CA\characters_E\civil\Tak_civil04\Data\Tak_civil04_3_co.paa"",""\CA\characters_E\civil\Tak_civil04\Data\Tak_civil04_4_co.paa"",""\CA\characters_E\civil\Tak_civil04\Data\Tak_civil04_5_co.paa""] select floor random 5]";
	};
	class TK_CIV_Takistani05_EP1 /* : TK_CIV_Takistani_Base_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\civil\Tak_civil05\Data\Tak_civil05_1_co.paa"",""\CA\characters_E\civil\Tak_civil05\Data\Tak_civil05_2_co.paa"",""\CA\characters_E\civil\Tak_civil05\Data\Tak_civil05_3_co.paa"",""\CA\characters_E\civil\Tak_civil05\Data\Tak_civil05_4_co.paa"",""\CA\characters_E\civil\Tak_civil05\Data\Tak_civil05_5_co.paa""] select floor random 5]";
	};
	class TK_CIV_Takistani06_EP1 /* : TK_CIV_Takistani_Base_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\civil\Tak_civil06\Data\Tak_civil06_1_co.paa"",""\CA\characters_E\civil\Tak_civil06\Data\Tak_civil06_2_co.paa"",""\CA\characters_E\civil\Tak_civil06\Data\Tak_civil06_3_co.paa"",""\CA\characters_E\civil\Tak_civil06\Data\Tak_civil06_4_co.paa"",""\CA\characters_E\civil\Tak_civil06\Data\Tak_civil06_5_co.paa""] select floor random 5]";
	};
	class TK_CIV_Woman01_EP1 /* : Woman_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\Woman\Tak_Woman01\Data\Tak_Woman01_1_co.paa"",""\CA\characters_E\Woman\Tak_Woman01\Data\Tak_Woman01_2_co.paa"",""\CA\characters_E\Woman\Tak_Woman01\Data\Tak_Woman01_3_co.paa"",""\CA\characters_E\Woman\Tak_Woman01\Data\Tak_Woman01_4_co.paa"",""\CA\characters_E\Woman\Tak_Woman01\Data\Tak_Woman01_5_co.paa""] select floor random 5]";
	};
	class TK_CIV_Woman02_EP1 /* : TK_CIV_Woman01_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\Woman\Tak_Woman02\Data\Tak_Woman02_1_co.paa"",""\CA\characters_E\Woman\Tak_Woman02\Data\Tak_Woman02_2_co.paa"",""\CA\characters_E\Woman\Tak_Woman02\Data\Tak_Woman02_3_co.paa"",""\CA\characters_E\Woman\Tak_Woman02\Data\Tak_Woman02_4_co.paa"",""\CA\characters_E\Woman\Tak_Woman02\Data\Tak_Woman02_5_co.paa""] select floor random 5]";
	};
	class TK_CIV_Woman03_EP1 /* : TK_CIV_Woman01_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\Woman\Tak_Woman03\Data\Tak_Woman03_1_co.paa"",""\CA\characters_E\Woman\Tak_Woman03\Data\Tak_Woman03_2_co.paa"",""\CA\characters_E\Woman\Tak_Woman03\Data\Tak_Woman03_3_co.paa"",""\CA\characters_E\Woman\Tak_Woman03\Data\Tak_Woman03_4_co.paa"",""\CA\characters_E\Woman\Tak_Woman03\Data\Tak_Woman03_5_co.paa""] select floor random 5]";
	};
	class Dr_Annie_Baker_EP1 /* : CIV_EuroWoman01_EP1 */ {
		SLX_BIS = "(_this select 0) setidentity ""Dr_Annie_Baker""";
	};
	class Rita_Ensler_EP1 /* : CIV_EuroWoman02_EP1 */ {
		SLX_BIS = "(_this select 0) setidentity ""Rita_Ensler""";
	};
	class Haris_Press_EP1 /* : CIV_EuroMan01_EP1 */ {
		SLX_BIS = "(_this select 0) setidentity ""Haris_Press_EP1""";
	};
	class Dr_Hladik_EP1 /* : CIV_EuroMan02_EP1 */ {
		SLX_BIS = "(_this select 0) setidentity ""Dr_Hladik""";
	};
	class TK_INS_Soldier_EP1 /* : TK_INS_Soldier_Base_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\LOC\Data\LOC_opfor01_1_co.paa"",""\CA\characters_E\LOC\Data\LOC_opfor01_2_co.paa"",""\CA\characters_E\LOC\Data\LOC_opfor01_3_co.paa""] select floor random 3]";
	};
	class TK_INS_Soldier_2_EP1 /* : TK_INS_Soldier_Base_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\LOC\Data\LOC_opfor04_1_co.paa"",""\CA\characters_E\LOC\Data\LOC_opfor04_2_co.paa"",""\CA\characters_E\LOC\Data\LOC_opfor04_3_co.paa""] select floor random 3]";
	};
	class TK_INS_Soldier_3_EP1 /* : TK_INS_Soldier_Base_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\LOC\Data\LOC_opfor02_1_co.paa"",""\CA\characters_E\LOC\Data\LOC_opfor02_2_co.paa"",""\CA\characters_E\LOC\Data\LOC_opfor02_3_co.paa""] select floor random 3]";
	};
	class TK_INS_Soldier_4_EP1 /* : TK_INS_Soldier_Base_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\LOC\Data\LOC_opfor05_1_co.paa"",""\CA\characters_E\LOC\Data\LOC_opfor05_2_co.paa"",""\CA\characters_E\LOC\Data\LOC_opfor05_3_co.paa""] select floor random 3]";
	};
	class TK_INS_Soldier_AA_EP1 /* : TK_INS_Soldier_Base_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\LOC\Data\LOC_opfor04_1_co.paa"",""\CA\characters_E\LOC\Data\LOC_opfor04_2_co.paa"",""\CA\characters_E\LOC\Data\LOC_opfor04_3_co.paa""] select floor random 3]";
	};
	class TK_INS_Soldier_AT_EP1 /* : TK_INS_Soldier_Base_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\LOC\Data\LOC_opfor01_1_co.paa"",""\CA\characters_E\LOC\Data\LOC_opfor01_2_co.paa"",""\CA\characters_E\LOC\Data\LOC_opfor01_3_co.paa""] select floor random 3]";
	};
	class TK_INS_Soldier_TL_EP1 /* : TK_INS_Soldier_Base_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\LOC\Data\LOC_opfor03_1_co.paa"",""\CA\characters_E\LOC\Data\LOC_opfor03_2_co.paa"",""\CA\characters_E\LOC\Data\LOC_opfor03_3_co.paa""] select floor random 3]";
	};
	class TK_INS_Soldier_Sniper_EP1 /* : TK_INS_Soldier_Base_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\LOC\Data\LOC_opfor03_1_co.paa"",""\CA\characters_E\LOC\Data\LOC_opfor03_2_co.paa"",""\CA\characters_E\LOC\Data\LOC_opfor03_3_co.paa""] select floor random 3]";
	};
	class TK_INS_Soldier_AR_EP1 /* : TK_INS_Soldier_Base_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\LOC\Data\LOC_opfor05_1_co.paa"",""\CA\characters_E\LOC\Data\LOC_opfor05_2_co.paa"",""\CA\characters_E\LOC\Data\LOC_opfor05_3_co.paa""] select floor random 3]";
	};
	class TK_INS_Soldier_MG_EP1 /* : TK_INS_Soldier_Base_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\LOC\Data\LOC_opfor02_1_co.paa"",""\CA\characters_E\LOC\Data\LOC_opfor02_2_co.paa"",""\CA\characters_E\LOC\Data\LOC_opfor02_3_co.paa""] select floor random 3]";
	};
	class TK_INS_Bonesetter_EP1 /* : TK_INS_Soldier_Base_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\LOC\Data\LOC_opfor05_1_co.paa"",""\CA\characters_E\LOC\Data\LOC_opfor05_2_co.paa"",""\CA\characters_E\LOC\Data\LOC_opfor05_3_co.paa""] select floor random 3]";
	};
	class TK_INS_Warlord_EP1 /* : TK_INS_Soldier_Base_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\LOC\Data\LOC_opfor02_1_co.paa"",""\CA\characters_E\LOC\Data\LOC_opfor02_2_co.paa"",""\CA\characters_E\LOC\Data\LOC_opfor02_3_co.paa""] select floor random 3]";
	};
	class TK_GUE_Soldier_EP1 /* : TK_GUE_Soldier_Base_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\LOC\Data\LOC_ind01_1_co.paa"",""\CA\characters_E\LOC\Data\LOC_ind01_2_co.paa"",""\CA\characters_E\LOC\Data\LOC_ind01_3_co.paa""] select floor random 3]";
	};
	class TK_GUE_Soldier_2_EP1 /* : TK_GUE_Soldier_Base_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\LOC\Data\LOC_ind04_1_co.paa"",""\CA\characters_E\LOC\Data\LOC_ind04_2_co.paa"",""\CA\characters_E\LOC\Data\LOC_ind04_3_co.paa""] select floor random 3]";
	};
	class TK_GUE_Soldier_3_EP1 /* : TK_GUE_Soldier_Base_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\LOC\Data\LOC_ind01_1_co.paa"",""\CA\characters_E\LOC\Data\LOC_ind01_2_co.paa"",""\CA\characters_E\LOC\Data\LOC_ind01_3_co.paa""] select floor random 3]";
	};
	class TK_GUE_Soldier_4_EP1 /* : TK_GUE_Soldier_Base_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\LOC\Data\LOC_ind03_1_co.paa"",""\CA\characters_E\LOC\Data\LOC_ind03_2_co.paa"",""\CA\characters_E\LOC\Data\LOC_ind03_3_co.paa""] select floor random 3]";
	};
	class TK_GUE_Soldier_5_EP1 /* : TK_GUE_Soldier_Base_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\LOC\Data\LOC_ind02_1_co.paa"",""\CA\characters_E\LOC\Data\LOC_ind02_2_co.paa"",""\CA\characters_E\LOC\Data\LOC_ind02_3_co.paa""] select floor random 3]";
	};
	class TK_GUE_Soldier_AA_EP1 /* : TK_GUE_Soldier_Base_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\LOC\Data\LOC_ind04_1_co.paa"",""\CA\characters_E\LOC\Data\LOC_ind04_2_co.paa"",""\CA\characters_E\LOC\Data\LOC_ind04_3_co.paa""] select floor random 3]";
	};
	class TK_GUE_Soldier_AT_EP1 /* : TK_GUE_Soldier_Base_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\LOC\Data\LOC_ind01_1_co.paa"",""\CA\characters_E\LOC\Data\LOC_ind01_2_co.paa"",""\CA\characters_E\LOC\Data\LOC_ind01_3_co.paa""] select floor random 3]";
	};
	class TK_GUE_Soldier_HAT_EP1 /* : TK_GUE_Soldier_Base_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\LOC\Data\LOC_ind01_1_co.paa"",""\CA\characters_E\LOC\Data\LOC_ind01_2_co.paa"",""\CA\characters_E\LOC\Data\LOC_ind01_3_co.paa""] select floor random 3]";
	};
	class TK_GUE_Soldier_TL_EP1 /* : TK_GUE_Soldier_Base_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\LOC\Data\LOC_ind04_1_co.paa"",""\CA\characters_E\LOC\Data\LOC_ind04_2_co.paa"",""\CA\characters_E\LOC\Data\LOC_ind04_3_co.paa""] select floor random 3]";
	};
	class TK_GUE_Soldier_Sniper_EP1 /* : TK_GUE_Soldier_Base_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\LOC\Data\LOC_ind03_1_co.paa"",""\CA\characters_E\LOC\Data\LOC_ind03_2_co.paa"",""\CA\characters_E\LOC\Data\LOC_ind03_3_co.paa""] select floor random 3]";
	};
	class TK_GUE_Soldier_AR_EP1 /* : TK_GUE_Soldier_Base_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\LOC\Data\LOC_ind05_1_co.paa"",""\CA\characters_E\LOC\Data\LOC_ind05_2_co.paa"",""\CA\characters_E\LOC\Data\LOC_ind05_3_co.paa""] select floor random 3]";
	};
	class TK_GUE_Soldier_MG_EP1 /* : TK_GUE_Soldier_Base_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\LOC\Data\LOC_ind02_1_co.paa"",""\CA\characters_E\LOC\Data\LOC_ind02_2_co.paa"",""\CA\characters_E\LOC\Data\LOC_ind02_3_co.paa""] select floor random 3]";
	};
	class TK_GUE_Bonesetter_EP1 /* : TK_GUE_Soldier_Base_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\LOC\Data\LOC_ind04_1_co.paa"",""\CA\characters_E\LOC\Data\LOC_ind04_2_co.paa"",""\CA\characters_E\LOC\Data\LOC_ind04_3_co.paa""] select floor random 3]";
	};
	class TK_GUE_Warlord_EP1 /* : TK_GUE_Soldier_Base_EP1 */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\characters_E\LOC\Data\LOC_ind02_1_co.paa"",""\CA\characters_E\LOC\Data\LOC_ind02_2_co.paa"",""\CA\characters_E\LOC\Data\LOC_ind02_3_co.paa""] select floor random 3]";
	};
	class Land_Fire_burning /* : Land_Fire */ {
		SLX_BIS = "(_this select 0) inflame true";
	};
	class Land_Campfire_burning /* : Land_Campfire */ {
		SLX_BIS = "(_this select 0) inflame true";
	};
	class Land_Fire_barrel_burning /* : Land_Fire_barrel */ {
		SLX_BIS = "(_this select 0) inflame true";
	};
	class FlagCarrierUSA /* : FlagCarrier */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""\ca\data\flag_usa_co.paa""";
	};
	class FlagCarrierCDF /* : FlagCarrierUSA */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""\ca\data\flag_Chernarus_co.paa""";
	};
	class FlagCarrierRU /* : FlagCarrierUSA */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""\ca\data\flag_rus_co.paa""";
	};
	class FlagCarrierINS /* : FlagCarrierUSA */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""\ca\data\flag_ChDKZ_co.paa""";
	};
	class FlagCarrierGUE /* : FlagCarrierUSA */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""\ca\data\flag_NAPA_co.paa""";
	};
	class FlagCarrierChecked /* : FlagCarrierCore */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""\ca\structures\misc\armory\checkered_flag\data\checker_flag_co.paa""";
	};
	class Barrack2 /* : Land_Barrack2 */ {
		SLX_BIS = "(_this select 0) setdir getdir (_this select 0)";
	};
	class Mass_grave /* : Grave */ {
		SLX_BIS = "dummy = _this execVM ""ca\characters2\OTHER\scripts\fly.sqf""";
	};
	class AAV /* : Tracked_APC */ {
		SLX_BIS = "if(isNil 'BIS_Effects_Init') then { call compile preProcessFileLineNumbers ""\ca\Data\ParticleEffects\SCRIPTS\init.sqf""; }; _this execVM ""\ca\tracked2\AAV\scripts\init.sqf""";
	};
	class Pickup_PK_TK_GUE_EP1 /* : Pickup_PK_base */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\wheeled_E\Datsun_Armed\Data\datsun_trup1_EINS_CO"",""\CA\wheeled_E\Datsun_Armed\Data\datsun_trup2_EINS_CO"",""\CA\wheeled_E\Datsun_Armed\Data\datsun_trup3_EINS_CO""] select floor random 3]";
	};
	class A10 /* : Plane */ {
		SLX_BIS = "if(isNil 'BIS_Effects_Init') then { call compile preProcessFileLineNumbers ""\ca\Data\ParticleEffects\SCRIPTS\init.sqf""; }";
	};
	class Su34 /* : Plane */ {
		SLX_BIS = "if(isNil 'BIS_Effects_Init') then { call compile preProcessFileLineNumbers ""\ca\Data\ParticleEffects\SCRIPTS\init.sqf""; }";
	};
	class AH6X_EP1 /* : AH6_Base_EP1 */ {
		SLX_BIS = "if(isNil 'BIS_Effects_Init') then { call compile preProcessFileLineNumbers ""\ca\Data\ParticleEffects\SCRIPTS\init.sqf""; }; (_this select 0) lockturret [[0],true];(_this select 0) lockturret [[1],true]";
	};
	class FlagCarrierUNO_EP1 /* : FlagCarrier */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""ca\Ca_E\data\flag_uno_co.paa""";
	};
	class FlagCarrierRedCrystal_EP1 /* : FlagCarrierUNO_EP1 */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""ca\Ca_E\data\flag_rcrystal_co.paa""";
	};
	class FlagCarrierTFKnight_EP1 /* : FlagCarrierUNO_EP1 */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""ca\Ca_E\data\flag_knight_co.paa""";
	};
	class FlagCarrierCDFEnsign_EP1 /* : FlagCarrierUNO_EP1 */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""ca\Ca_E\data\flag_cdf_co.paa""";
	};
	class FlagCarrierRedCross_EP1 /* : FlagCarrierUNO_EP1 */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""ca\Ca_E\data\flag_rcross_co.paa""";
	};
	class FlagCarrierUSArmy_EP1 /* : FlagCarrierUNO_EP1 */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""ca\Ca_E\data\flag_usarmy_co.paa""";
	};
	class FlagCarrierTKMilitia_EP1 /* : FlagCarrierUNO_EP1 */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""ca\Ca_E\data\flag_tkm_co.paa""";
	};
	class FlagCarrierRedCrescent_EP1 /* : FlagCarrierUNO_EP1 */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""ca\Ca_E\data\flag_rcrescent_co.paa""";
	};
	class FlagCarrierGermany_EP1 /* : FlagCarrierUNO_EP1 */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""ca\Ca_E\data\flag_ger_co.paa""";
	};
	class FlagCarrierNATO_EP1 /* : FlagCarrierUNO_EP1 */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""ca\Ca_E\data\flag_nato_co.paa""";
	};
	class FlagCarrierBIS_EP1 /* : FlagCarrierUNO_EP1 */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""ca\Ca_E\data\flag_bis_co.paa""";
	};
	class FlagCarrierCzechRepublic_EP1 /* : FlagCarrierUNO_EP1 */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""ca\Ca_E\data\flag_cz_co.paa""";
	};
	class FlagCarrierPOWMIA_EP1 /* : FlagCarrierUNO_EP1 */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""ca\Ca_E\data\flag_pow_co.paa""";
	};
	class FlagCarrierBLUFOR_EP1 /* : FlagCarrierUNO_EP1 */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""ca\Ca_E\data\flag_blufor_co.paa""";
	};
	class FlagCarrierOPFOR_EP1 /* : FlagCarrierUNO_EP1 */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""ca\Ca_E\data\flag_opfor_co.paa""";
	};
	class FlagCarrierINDFOR_EP1 /* : FlagCarrierUNO_EP1 */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""ca\Ca_E\data\flag_indfor_co.paa""";
	};
	class FlagCarrierTakistan_EP1 /* : FlagCarrierUNO_EP1 */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""ca\Ca_E\data\flag_tka_co.paa""";
	};
	class FlagCarrierTakistanKingdom_EP1 /* : FlagCarrierUNO_EP1 */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""ca\Ca_E\data\flag_tkg_co.paa""";
	};
	class FlagCarrierUSA_EP1 /* : FlagCarrierUNO_EP1 */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""ca\Ca_E\data\flag_us_co.paa""";
	};
	class FlagCarrierCDF_EP1 /* : FlagCarrierUNO_EP1 */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""ca\Ca_E\data\flag_cr_co.paa""";
	};
	class FlagCarrierWhite_EP1 /* : FlagCarrierUNO_EP1 */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""ca\Ca_E\data\flag_white_co.paa""";
	};
};
class Extended_fired_Eventhandlers {}; // Backwards compatibility, uses XEH notation

class Extended_firedBis_Eventhandlers { // New fired EH, uses BIS notation
	class StaticCannon /* : StaticWeapon */ {
		SLX_BIS = "_this call BIS_Effects_EH_Fired";
	};
	class M252 /* : StaticMortar */ {
		SLX_BIS = "_this call BIS_Effects_EH_Fired";
	};
	class 2b14_82mm /* : StaticMortar */ {
		SLX_BIS = "_this call BIS_Effects_EH_Fired";
	};
	class A10 /* : Plane */ {
		SLX_BIS = "_this call BIS_Effects_EH_Fired";
	};
	class Su34 /* : Plane */ {
		SLX_BIS = "_this call BIS_Effects_EH_Fired";
	};
};

class Extended_firednear_Eventhandlers {
	class CAAnimalBase /* : Animal */ {
		SLX_BIS = "_this execFSM ""CA\animals2\Data\scripts\reactFire.fsm""";
	};
};
class Extended_hit_Eventhandlers {
	class TargetPopUpTarget /* : TargetBase */ {
		SLX_BIS = "[(_this select 0)] execVM ""ca\misc\scripts\PopUpTarget.sqf""";
	};
	class TargetEpopup /* : TargetBase */ {
		SLX_BIS = "[(_this select 0)] execVM ""ca\misc\scripts\PopUpTarget.sqf""";
	};
};
class Extended_killed_Eventhandlers {
	class A10 /* : Plane */ {
		SLX_BIS = "_this call BIS_Effects_EH_Killed";
	};
	class Su34 /* : Plane */ {
		SLX_BIS = "_this call BIS_Effects_EH_Killed";
	};
};

class Extended_AnimChanged_EventHandlers {};
class Extended_AnimDone_EventHandlers {};
class Extended_Dammaged_EventHandlers {};
class Extended_Engine_EventHandlers {};

class Extended_Fuel_EventHandlers {};
class Extended_Gear_EventHandlers {};
class Extended_IncomingMissile_EventHandlers {};

class Extended_LandedTouchDown_EventHandlers {};
class Extended_LandedStopped_EventHandlers {};
class Extended_HandleDamage_EventHandlers {};

class Extended_GetIn_EventHandlers
{
	// Default Extended Event Handlers: Custom GetInMan event
	class AllVehicles
	{
		class SLX_GetInMan
		{
				scope	 = public;
				getIn  = "_this call SLX_XEH_EH_GetInMan";
		};
	};
};
class Extended_GetOut_EventHandlers
{
	// Default Extended Event Handlers: Custom GetOutMan event
	class AllVehicles
	{
		class SLX_GetOutMan
		{
				scope	 = public;
				getOut = "_this call SLX_XEH_EH_GetOutMan";
		};
	};
};

class Extended_GetInMan_EventHandlers {};
class Extended_GetOutMan_EventHandlers {};

// New OA 1.55 classes
// TODO: What about Vehicle Respawn?
// TODO: MPRespawn vs Respawn seems unclear, only respawn seems to work?
// Respawn only seems to fire where the unit is local, but MPRespawn or MPKilled nowhere??
class Extended_Respawn_EventHandlers
{
	// We use this to re-attach eventhandlers on respawn, just like ordinary eventhandlers are re-attached.
	// We also use it to rerun init eventhandlers with onRespawn = true; functionallity now sort of shared with MPRespawn EH etc.
	// This is required because BIS Initeventhandlers fire on all machines for respawning unit, except on his own machine.
	class CAManBase
	{
		class SLX_RespawnInit
		{
				scope	 = public;
				respawn  = "_this call SLX_XEH_EH_RespawnInit";
		};
	};
};

/*
// Don't work
class Extended_MPHit_EventHandlers {};
class Extended_MPKilled_EventHandlers {};
class Extended_MPRespawn_EventHandlers
{
};
*/
class DefaultEventhandlers // external - BIS default event handlers in ArmA 2
{
	init = "if(isNil 'BIS_Effects_Init') then { call compile preProcessFileLineNumbers ""\ca\Data\ParticleEffects\SCRIPTS\init.sqf""; }";
	// Replace fired with firedBis
	delete fired;
	firedBis = "_this call BIS_Effects_EH_Fired"; // Have to convert between XEH _projectile @ _this select 5,  and BIS _projectile @ _this select 6.
	killed = "_this call BIS_Effects_EH_Killed";
};
