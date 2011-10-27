// XEH uses all existing event handlers
#define EXTENDED_EVENTHANDLERS init = QUOTE(if(isNil'SLX_XEH_MACHINE')then{call compile preProcessFileLineNumbers 'extended_eventhandlers\init_pre.sqf'};_this call SLX_XEH_EH_Init); \
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
class Extended_init_Eventhandlers {
	class Pilot_Random_H /* : Pilot_Base_H */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\HSim\Characters_H\Pilots\Pilot\Data\Pilot_1_co.paa"",""\HSim\Characters_H\Pilots\Pilot\Data\Pilot_2_co.paa"",""\HSim\Characters_H\Pilots\Pilot\Data\Pilot_3_co.paa"",""\HSim\Characters_H\Pilots\Pilot\Data\Pilot_4_co.paa"",""\HSim\Characters_H\Pilots\Pilot\Data\Pilot_5_co.paa""] select floor random 5];";
	};
	class Functionary_Random_H /* : Functionary_Base_H */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\hsim\characters_h\functionary\data\functionary_co.paa"",""\hsim\characters_h\functionary\data\functionary2_co.paa""] select floor random 2];";
	};
	class Citizen_Random_H /* : Citizen_Base_H */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\HSim\Characters_H\Citizen\data\citizen_co.paa"",""\HSim\Characters_H\Citizen\data\Citizen_v2_co.paa"",""\HSim\Characters_H\Citizen\data\Citizen_v3_co.paa"",""\HSim\Characters_H\Citizen\data\Citizen_v4_co.paa""] select floor random 4];";
	};
	class Workman_Random_H /* : Workman_Base_H */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\HSim\Characters_H\SpecialCharacters\Mechanic\data\Mechanic_1_CO.paa"",""\HSim\Characters_H\SpecialCharacters\Mechanic\data\Mechanic_2_CO.paa""] select floor random 2];";
	};
	class SeattleMan_Random_H /* : SeattleMan_Base_H */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\hsim\characters_h\specialcharacters\brother\data\man_1_co.paa"",""\hsim\characters_h\specialcharacters\brother\data\man_2_co.paa"",""\hsim\characters_h\specialcharacters\brother\data\man_3_co.paa""] select floor random 3];";
	};
	class Woman01_Random_H /* : Woman01_Base_H */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\HSim\Characters_H\women\data\damsel1_co.paa"",""HSim\Characters_H\women\data\damsel2_co.paa"",""HSim\Characters_H\women\data\damsel3_co.paa"",""HSim\Characters_H\women\data\damsel4_co.paa"",""HSim\Characters_H\women\data\damsel5_co.paa""] select floor random 5];";
	};
	class Woman02_Random_H /* : Woman02_Base_H */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\HSim\Characters_H\women\data\secretary1_co.paa"",""HSim\Characters_H\women\data\secretary2_co.paa"",""HSim\Characters_H\women\data\secretary3_co.paa"",""HSim\Characters_H\women\data\secretary4_co.paa"",""HSim\Characters_H\women\data\secretary5_co.paa""] select floor random 5];";
	};
	class Woman03_Random_H /* : Woman03_Base_H */ {
		SLX_BIS = "(_this select 0) setObjectTexture [0,[""\HSim\Characters_H\women\data\sportswoman1_co.paa"",""HSim\Characters_H\women\data\sportswoman2_co.paa"",""HSim\Characters_H\women\data\sportswoman3_co.paa"",""HSim\Characters_H\women\data\sportswoman4_co.paa"",""HSim\Characters_H\women\data\sportswoman5_co.paa""] select floor random 5];";
	};
	class Helicopter_Base_H /* : Helicopter */ {
		SLX_BIS = "private ['_handle']; _handle = execVM '\hsim\air_h\data\scripts\turbulence.sqf'; _handle = (_this select 0) execVM '\hsim\air_h\data\scripts\cockpit.sqf'";
	};
	class FlagCarrier_USA_H /* : FlagCarrier_Base_H */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""\HSim\Data_H\data\flag_usa_co.paa""";
	};
	class FlagCarrier_Vrana_H /* : FlagCarrier_Base_H */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""\HSim\Misc_H\Info_Board\data\vrana_logo_co.paa""";
	};
	class FlagCarrier_Larkin_H /* : FlagCarrier_Base_H */ {
		SLX_BIS = "(_this select 0) setFlagTexture ""\HSim\Misc_H\Info_Board\data\larkin_logo_co.paa""";
	};
};
class Extended_firednear_Eventhandlers {
	class Animal_Base_H /* : Animal */ {
		SLX_BIS = "_this execFSM ""hsim\animals_H\Data\scripts\reactFire.fsm"";";
	};
};
class Extended_dammaged_Eventhandlers {
	class Helicopter_Base_H /* : Helicopter */ {
		SLX_BIS = "_this call (uiNamespace getVariable 'BIS_fnc_helicopterDamage')";
	};
};
class Extended_hit_Eventhandlers {
	class Target_Person_PopUp_H /* : Target_Base_H */ {
		SLX_BIS = "[(_this select 0)] execVM ""HSim\Misc_H\data\scripts\PopUpTarget.sqf""";
	};
	class Target_PopUp_H /* : Target_Base_H */ {
		SLX_BIS = "[(_this select 0)] execVM ""HSim\Misc_H\data\scripts\PopUpTarget.sqf""";
	};
};

class Extended_fired_Eventhandlers {}; // Backwards compatibility, uses XEH notation

class Extended_firedBis_Eventhandlers { // New fired EH, uses BIS notation
};

class Extended_killed_Eventhandlers {
};

class Extended_AnimChanged_EventHandlers {};
class Extended_AnimStateChanged_EventHandlers {};
class Extended_AnimDone_EventHandlers {};
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
	init = QUOTE(if(isNil 'BIS_Effects_Init') then { call COMPILE_FILE2(\ca\Data\ParticleEffects\SCRIPTS\init.sqf) });
	// Replace fired with firedBis
	delete fired;
	firedBis = "_this call BIS_Effects_EH_Fired"; // Have to convert between XEH _projectile @ _this select 5,  and BIS _projectile @ _this select 6.
	killed = "_this call BIS_Effects_EH_Killed";
};
