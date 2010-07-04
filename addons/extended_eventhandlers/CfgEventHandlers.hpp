// XEH uses all existing event handlers
#define EXTENDED_EVENTHANDLERS init = "if(isnil'SLX_XEH_objects')then{call compile preprocessFile'extended_eventhandlers\InitXEH.sqf'};[_this select 0,'Extended_Init_EventHandlers']call SLX_XEH_init;"; \
fired = "_s=nearestObject[_this select 0,_this select 4]; [_this select 0,_this select 1,_this select 2,_this select 3,_this select 4,_s]call((_this select 0)getVariable'Extended_FiredEH')"; \
animChanged      = "{_this call _x}forEach((_this select 0)getVariable'Extended_AnimChangedEH')"; \
animStateChanged = "{_this call _x}forEach((_this select 0)getVariable'Extended_AnimStateChangedEH')"; \
animDone         = "{_this call _x}forEach((_this select 0)getVariable'Extended_AnimDoneEH')"; \
dammaged         = "{_this call _x}forEach((_this select 0)getVariable'Extended_DammagedEH')"; \
engine           = "{_this call _x}forEach((_this select 0)getVariable'Extended_EngineEH')"; \
firedNear        = "{_this call _x}forEach((_this select 0)getVariable'Extended_FiredNearEH')"; \
fuel             = "{_this call _x}forEach((_this select 0)getVariable'Extended_FuelEH')"; \
gear             = "{_this call _x}forEach((_this select 0)getVariable'Extended_GearEH')"; \
getIn            = "{_this call _x}forEach((_this select 0)getVariable'Extended_GetInEH')"; \
getOut           = "{_this call _x}forEach((_this select 0)getVariable'Extended_GetOutEH')"; \
hit              = "{_this call _x}forEach((_this select 0)getVariable'Extended_HitEH')"; \
incomingMissile  = "{_this call _x}forEach((_this select 0)getVariable'Extended_IncomingMissileEH')"; \
killed           = "{_this call _x}forEach((_this select 0)getVariable'Extended_KilledEH')"; \
landedTouchDown  = "{_this call _x}forEach((_this select 0)getVariable'Extended_LandedTouchDownEH')"; \
landedStopped    = "{_this call _x}forEach((_this select 0)getVariable'Extended_LandedStoppedEH')"; // \
//handleDamage     = "{_this call _x}forEach((_this select 0)getVariable'Extended_HandleDamageEH')"; \
//handleHealing    = "{_this call _x}forEach((_this select 0)getVariable'Extended_HandleHealingEH')";


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
class Extended_InitPost_EventHandlers
{
	class All
	{
		// Compile code for other EHs to run and put them in the setVariable.
		// Set up code for the remaining event handlers too...
		class SLX_Init_Other_All
		{
			scope	 = public;
			onRespawn = false;   // Not needed in A2 for SLX_XEH_initOthers
			init	  = "_this call SLX_XEH_initOthers";
		};
	};
};

// Extended EH classes, where new events are defined.
class Extended_Init_EventHandlers
{
	// Default Extended Event Handlers: Add extended event handlers to compile code.
	class All
	{
		class SLX_Init_Post_All
		{
				scope	 = public;
				onRespawn = false;   // A2 keeps object variables after respawn
				init	  = "_this call SLX_XEH_initPost";
		};
	};

	// Vehicles.
	class StaticCannon /* : StaticWeapon */ {
		SLX_BIS = "_scr = _this execVM ""\ca\Data\ParticleEffects\SCRIPTS\init.sqf"";";
	};
	class BIS_Effect_FilmGrain /* : Logic */ {
		SLX_BIS = """filmGrain"" ppEffectEnable true;   ""filmGrain"" ppEffectAdjust [0.03, 1, 1, 0.1, 1, false];  ""filmGrain"" ppEffectCommit 0;   ";
	};
	class BIS_Effect_Day /* : Logic */ {
		SLX_BIS = """colorCorrections"" ppEffectAdjust [1, 1.02, -0.005, [0.0, 0.0, 0.0, 0.0], [1, 0.8, 0.6, 0.65],  [0.199, 0.587, 0.114, 0.0]];   ""colorCorrections"" ppEffectCommit 0;      ""colorCorrections"" ppEffectEnable true";
	};
	class BIS_Effect_MovieNight /* : Logic */ {
		SLX_BIS = """colorCorrections"" ppEffectAdjust [1, 1.15, 0, [0.0, 0.0, 0.0, 0.0], [0.5, 0.8, 1, 0.5],  [0.199, 0.587, 0.114, 0.0]];   ""colorCorrections"" ppEffectCommit 0; ""colorCorrections"" ppEffectEnable true;";
	};
	class BIS_Effect_Sepia /* : Logic */ {
		SLX_BIS = """colorCorrections"" ppEffectAdjust [1, 1.06, -0.01, [0.0, 0.0, 0.0, 0.0], [0.44, 0.26, 0.078, 0],  [0.199, 0.587, 0.114, 0.0]];   ""colorCorrections"" ppEffectCommit 0; ""colorCorrections"" ppEffectEnable true;";
	};
	class AlternativeInjurySimulation /* : Logic */ {
		SLX_BIS = "[] call (compile (preprocessFileLineNumbers (""\ca\Modules\MP\data\scripts\MPframework.sqf""))); _ok = _this execVM ""\ca\Modules\AIS\data\scripts\ISserverStartUsingLogic.sqf""";
	};
	class AliceManager /* : Logic */ {
		SLX_BIS = "if (isnil 'BIS_alice_mainscope') then {BIS_alice_mainscope = _this select 0; publicvariable 'BIS_alice_mainscope'; if (isServer) then {private [""_ok""];_ok = _this execVM ""ca\modules\alice\data\scripts\main.sqf""};};";
	};
	class AmbientCombatManager /* : Logic */ {
		SLX_BIS = "private [""_ok""]; _ok = (_this select 0) execVM ""ca\modules\ambient_combat\data\scripts\init.sqf""";
	};
	class BIS_animals_Logic /* : Logic */ {
		SLX_BIS = "_this execVM '\CA\Modules\Animals\Data\scripts\init.sqf';";
	};
	class BattleFieldClearance /* : Logic */ {
		SLX_BIS = "[] call (compile (preprocessFileLineNumbers (""\ca\Modules\MP\data\scripts\MPframework.sqf""))); _ok = _this execVM ""\ca\Modules\BC\data\scripts\BCserverStartUsingLogic.sqf""";
	};
	class BIS_clouds_Logic /* : Logic */ {
		SLX_BIS = "_this exec '\ca\modules\Clouds\data\scripts\BIS_CloudSystem.sqs'";
	};
	class ConstructionManager /* : Logic */ {
		SLX_BIS = "if (isServer) then {private [""_ok""];_ok = _this execVM ""ca\modules\coin\data\scripts\coin.sqf""};";
	};
	class FirstAidSystem /* : Logic */ {
		SLX_BIS = "[] call (compile (preprocessFileLineNumbers (""\ca\Modules\MP\data\scripts\MPframework.sqf""))); _ok = _this execVM ""\ca\Modules\FA\data\scripts\FAserverStartUsingLogic.sqf""";
	};
	class FunctionsManager /* : Logic */ {
		SLX_BIS = "textLogFormat ['PRELOAD_ Functions\init %1', [_this, BIS_functions_mainscope]]; 	if (isnil 'BIS_functions_mainscope') then 	{ BIS_functions_mainscope = _this select 0;  if (isServer) then {_this execVM 'ca\modules\functions\main.sqf'};} else {_this spawn { textLogFormat ['PRELOAD_ Functions\init  ERROR: deleting redundant FM! %1', [_this, (_this select 0), BIS_functions_mainscope]]; _mygrp = group (_this select 0); deleteVehicle (_this select 0); deleteGroup _mygrp;};}; 			  if (isnil 'RE') then {[] execVM '\ca\Modules\MP\data\scripts\MPframework.sqf'};	";
	};
	class PreloadManager /* : Logic */ {
		SLX_BIS = "onPreloadStarted {BIS_PRELOAD_ARRAY=[];textLogFormat['PRELOAD_ Preload Manager - onPreloadStarted, _maxTime %1 timenow %2',_maxTime,time];startLoadingScreen[localize 'str_load_game','RscDisplayLoadMission'];};onPreloadFinished {	textLogFormat['PRELOAD_  Preload Manager - onPreloadFinished T %1',time];	startLoadingScreen['','RscDisplayLoadMission'];	endLoadingScreen;			};	";
	};
	class GarbageCollector /* : Logic */ {
		SLX_BIS = "private [""_ok""]; _ok = (_this select 0) execVM ""ca\modules\garbage_collector\data\scripts\init.sqf""";
	};
	class HighCommand /* : Logic */ {
		SLX_BIS = "if (isServer) then {if (isnil 'BIS_HC_mainscope') then {BIS_HC_mainscope = _this select 0; publicvariable 'bis_hc_mainscope'}; _ok = _this execVM '\ca\Modules\HC\data\scripts\hc.sqf'}; if (isnil 'RE') then {private [""_ok""]; _ok = [] execVM '\ca\Modules\MP\data\scripts\MPframework.sqf'}";
	};
	class MartaManager /* : Logic */ {
		SLX_BIS = "if (isnil 'BIS_marta_mainscope') then {BIS_marta_mainscope = _this select 0; if (isServer) then {private [""_ok""];_ok = _this execVM ""ca\modules\marta\data\scripts\main.sqf""}}; if (isnil 'RE') then {private [""_ok""]; _ok = [] execVM '\ca\Modules\MP\data\scripts\MPframework.sqf'};";
	};
	class SilvieManager /* : Logic */ {
		SLX_BIS = "if (isnil 'BIS_silvie_mainscope') then {BIS_silvie_mainscope = _this select 0; if (isServer) then {private [""_ok""];_ok = _this execVM ""ca\modules\silvie\data\scripts\main.sqf""};};";
	};
	class BIS_SRRS_Logic /* : Logic */ {
		SLX_BIS = "_ok = _this execVM '\ca\modules\srrs\data\scripts\init.sqf'";
	};
	class UAVManager /* : Logic */ {
		SLX_BIS = "if (isServer) then {private [""_ok""];_ok = _this execVM ""ca\modules_e\uav\data\scripts\uav.sqf""};";
	};
	class ZoraManager /* : Logic */ {
		SLX_BIS = "if (isnil 'BIS_Zora_mainscope') then {BIS_Zora_MainScope = _this select 0; if (isServer) then {private [""_ok""];_ok = _this execVM ""ca\modules\zora\data\scripts\main.sqf""};};";
	};
	class Alice2Manager /* : Logic */ {
		SLX_BIS = "if (isnil 'BIS_alice_mainscope') then {BIS_alice_mainscope = _this select 0; publicvariable 'BIS_alice_mainscope'; if (isServer) then {private [""_ok""];_ok = _this execVM ""ca\modules_e\alice2\data\scripts\main.sqf""};};";
	};
	class GitaManager /* : Logic */ {
		SLX_BIS = "if (isServer) then {private [""_ok""];_ok = _this execVM ""ca\modules_e\gita\data\scripts\main.sqf""}; if (isnil 'RE') then {private [""_ok""]; _ok = [] execVM '\ca\Modules\MP\data\scripts\MPframework.sqf'};";
	};
	class JukeboxManager /* : Logic */ {
		SLX_BIS = "_ok = _this execVM ""ca\modules_e\jukebox\data\scripts\jukebox.sqf"";";
	};
	class BIS_Support /* : Logic */ {
		SLX_BIS = "_this execVM '\ca\modules_e\ssm\data\scripts\init.sqf' ";
	};
	class UAV_HeliManager /* : Logic */ {
		SLX_BIS = "if (isServer) then {private [""_ok""];_ok = _this execVM ""ca\modules_e\uav_heli\data\scripts\uav.sqf""};";
	};
	class WeatherPostprocessManager /* : Logic */ {
		SLX_BIS = "if (isnil 'BIS_WeatherPostprocess_logic') then {BIS_WeatherPostprocess_logic = _this select 0; if (isServer) then {private [""_ok""];_ok = _this execVM ""ca\modules_e\weather\data\scripts\main.sqf""}; if (isnil 'RE') then {private [""_ok""]; _ok = [] execVM '\ca\Modules\MP\data\scripts\MPframework.sqf'};};";
	};
	class WeatherParticlesManager /* : Logic */ {
		SLX_BIS = "if (isnil 'BIS_WeatherParticles_logic') then {BIS_WeatherParticles_logic = _this select 0; if (isServer) then {private [""_ok""];_ok = _this execVM ""ca\modules_e\weather\data\scripts\main.sqf""}; if (isnil 'RE') then {private [""_ok""]; _ok = [] execVM '\ca\Modules\MP\data\scripts\MPframework.sqf'};};";
	};
	class M252 /* : StaticMortar */ {
		SLX_BIS = "_scr = _this execVM ""\ca\Data\ParticleEffects\SCRIPTS\init.sqf"";";
	};
	class 2b14_82mm /* : StaticMortar */ {
		SLX_BIS = "_scr = _this execVM ""\ca\Data\ParticleEffects\SCRIPTS\init.sqf"";";
	};
	class SecOpManager /* : Logic */ {
		SLX_BIS = "private [""_ok""]; _ok = (_this select 0) execVM ""ca\missions\som\data\scripts\init.sqf""";
	};
	class StrategicReferenceLayer /* : Logic */ {
		SLX_BIS = "private [""_ok""]; _ok = (_this select 0) execVM ""ca\modules\strat_layer\data\scripts\init.sqf""";
	};
	class WarfareOA /* : Logic */ {
		SLX_BIS = "BIS_WF_UI = 'OA';BIS_WF_OA = true;if (IsNil {BIS_WF_Common}) then {BIS_WF_Common = _this select 0;Private [""_nullReturn""];_nullReturn = [false,'\CA\Warfare2_E\Scripts\'] ExecVM ""ca\Warfare2\Scripts\Init.sqf"";};";
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
		SLX_BIS = "_scr = _this execVM ""\ca\Data\ParticleEffects\SCRIPTS\init.sqf"";_this execVM ""\ca\tracked2\AAV\scripts\init.sqf""";
	};
	class Pickup_PK_TK_GUE_EP1 /* : Pickup_PK_base */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\CA\wheeled_E\Datsun_Armed\Data\datsun_trup1_EINS_CO"",""\CA\wheeled_E\Datsun_Armed\Data\datsun_trup2_EINS_CO"",""\CA\wheeled_E\Datsun_Armed\Data\datsun_trup3_EINS_CO""] select floor random 3]";
	};
	class A10 /* : Plane */ {
		SLX_BIS = "_scr = _this execVM ""\ca\Data\ParticleEffects\SCRIPTS\init.sqf"";";
	};
	class Su34 /* : Plane */ {
		SLX_BIS = "_scr = _this execVM ""\ca\Data\ParticleEffects\SCRIPTS\init.sqf"";";
	};
	class AH6X_EP1 /* : AH6_Base_EP1 */ {
		SLX_BIS = "_scr = _this execVM ""\ca\Data\ParticleEffects\SCRIPTS\init.sqf"";(_this select 0) lockturret [[0],true];(_this select 0) lockturret [[1],true];";
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
	class BIS_ARTY_Logic /* : Logic */ {
		SLX_BIS = "_script = _this execVM '\ca\modules\arty\data\scripts\init.sqf'";
	};
	class BIS_ARTY_Virtual_Artillery /* : Logic */ {
		SLX_BIS = "_script = _this execVM '\ca\modules\arty\data\scripts\ARTY_initVirtual.sqf'";
	};
	class Warfare /* : Logic */ {
		SLX_BIS = "if (IsNil {BIS_WF_Common}) then {BIS_WF_Common = _this select 0;Private [""_nullReturn""];_nullReturn = [false] ExecVM ""ca\Warfare2\Scripts\Init.sqf"";};";
	};
};
class Extended_fired_Eventhandlers {
	class StaticCannon /* : StaticWeapon */ {
		SLX_BIS = "_this call BIS_Effects_EH_Fired;";
	};
	class M252 /* : StaticMortar */ {
		SLX_BIS = "_this call BIS_Effects_EH_Fired;";
	};
	class 2b14_82mm /* : StaticMortar */ {
		SLX_BIS = "_this call BIS_Effects_EH_Fired;";
	};
	class A10 /* : Plane */ {
		SLX_BIS = "_this call BIS_Effects_EH_Fired;";
	};
	class Su34 /* : Plane */ {
		SLX_BIS = "_this call BIS_Effects_EH_Fired;";
	};
};
class Extended_firednear_Eventhandlers {
	class CAAnimalBase /* : Animal */ {
		SLX_BIS = "_this execFSM ""CA\animals2\Data\scripts\reactFire.fsm"";";
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
		SLX_BIS = "_this call BIS_Effects_EH_Killed;";
	};
	class Su34 /* : Plane */ {
		SLX_BIS = "_this call BIS_Effects_EH_Killed;";
	};
};

class Extended_AnimChanged_EventHandlers {};
class Extended_AnimDone_EventHandlers {};
class Extended_Dammaged_EventHandlers {};
class Extended_Engine_EventHandlers {};

class Extended_Fuel_EventHandlers {};
class Extended_Gear_EventHandlers {};
class Extended_GetIn_EventHandlers {};
class Extended_GetOut_EventHandlers {};
class Extended_IncomingMissile_EventHandlers {};

class Extended_LandedTouchDown_EventHandlers {};
class Extended_LandedStopped_EventHandlers {};
class Extended_HandleDamage_EventHandlers {};


class DefaultEventhandlers; // external - BIS default event handlers in ArmA 2
