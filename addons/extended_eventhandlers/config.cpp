#define false 0
#define true 1

#define private 0
#define public 2

// Extended event handlers by Solus and Killswitch
class CfgPatches
{
	class Extended_EventHandlers
	{
		units[] = {};
		requiredVersion = 1.00;
		//requiredAddons[] = { "CACharacters", "CAWeapons", "CAWeapons3", "CAAir" };
        requiredAddons[] = { "CAData", "CAAir", "CACharacters" };
		SLX_XEH2_Version = 1.991;
	};
};

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

// XEH uses all existing event handlers
#define EXTENDED_EVENTHANDLERS init = "if(isnil'SLX_XEH_objects')then { call compile preprocessFile'x\cba\addons\extended_eventhandlers\InitXEH.sqf'}; [_this select 0,'Extended_Init_EventHandlers']call SLX_XEH_init"; \
fired = "_s = nearestObject[_this select 0,_this select 4]; [_this select 0,_this select 1,_this select 2,_this select 3,_this select 4,_s]call((_this select 0)getVariable'Extended_FiredEH')"; \
animChanged     = "_this call((_this select 0)getVariable'Extended_AnimChangedEH')"; \
animDone        = "_this call((_this select 0)getVariable'Extended_AnimDoneEH')"; \
dammaged        = "_this call((_this select 0)getVariable'Extended_DammagedEH')"; \
engine          = "_this call((_this select 0)getVariable'Extended_EngineEH')"; \
firedNear       = "_this call((_this select 0)getVariable'Extended_FiredNearEH')"; \
fuel            = "_this call((_this select 0)getVariable'Extended_FuelEH')"; \
gear            = "_this call((_this select 0)getVariable'Extended_GearEH')"; \
getIn           = "_this call((_this select 0)getVariable'Extended_GetInEH')"; \
getOut          = "_this call((_this select 0)getVariable'Extended_GetOutEH')"; \
hit             = "_this call((_this select 0)getVariable'Extended_HitEH')"; \
incomingMissile = "_this call((_this select 0)getVariable'Extended_IncomingMissileEH')"; \
killed          = "_this call((_this select 0)getVariable'Extended_KilledEH')"; \
landedTouchDown = "_this call((_this select 0)getVariable'Extended_LandedTouchDownEH')"; \
landedStopped   = "_this call((_this select 0)getVariable'Extended_LandedStoppedEH')"; \
handleDamage   = "_this call((_this select 0)getVariable'Extended_HandleDamageEH')";

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
// Default Extended Event Handlers: Add extended event handlers to compile code.
	class All
	{
		// Compile code for other EHs to run and put them in the setVariable.
		// Set up code for the remaining event handlers too...
		class SLX_Init_Other_All
		{
			scope     = public;
			onRespawn = true;   // Run this EH when a unit respawns
			init      = "_this call SLX_XEH_initOthers";
		};
	};
    class AAV
    {
        class SLX_BIS_AAV_Init
        {
            scope = public;
            init  = "_this execVM'\ca\tracked2\AAV\scripts\init.sqf'";
            replaceDEH = true;  // replace the BIS DefaultEventhandlers init
                                // since this is what the stock BIS AAV does
        };
    };
    class StaticCannon
    {
        SLX_BIS_StaticCannon_Init = "_scr = _this execVM'\ca\Data\ParticleEffects\SCRIPTS\init.sqf'";
    };
};
class Extended_AnimChanged_EventHandlers {};
class Extended_AnimDone_EventHandlers {};
class Extended_Dammaged_EventHandlers {};
class Extended_Engine_EventHandlers {};
class Extended_Fired_EventHandlers
{
    class StaticCannon
    {
        // Stock BIS fired EH for the StaticCannon class
        SLX_BIS_StaticCannon_fired ="_this call BIS_Effects_EH_Fired";
    };
};
class Extended_FiredNear_EventHandlers
{
    class CAAnimalBase
    {
        SLX_BIS_CAAnimalBase_firedNear = "_this execFSM'CA\animals2\Data\scripts\reactFire.fsm'";
    };
};
class Extended_Fuel_EventHandlers {};
class Extended_Gear_EventHandlers {};
class Extended_GetIn_EventHandlers {};
class Extended_GetOut_EventHandlers {};
class Extended_Hit_EventHandlers {};
class Extended_IncomingMissile_EventHandlers {};
class Extended_Killed_EventHandlers {};
class Extended_LandedTouchDown_EventHandlers {};
class Extended_LandedStopped_EventHandlers {};


class DefaultEventhandlers; // external - BIS default event handlers in ArmA 2

// Make event handler classes have the extended event handlers.
class CfgVehicles
{
	class All;
    class Air;
    class Animal;
    class LandVehicle;
	class Man;
    class Tracked_APC;
    class StaticWeapon;
    
    class AAV: Tracked_APC
	{
		 class EventHandlers : DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class AllVehicles: All
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
    class CAAnimalBase: Animal
	{
		 class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
    class CAManBase: Man
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
    class Car: LandVehicle
	{
		class EventHandlers : DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class Helicopter: Air
	{
		class EventHandlers : DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class Plane: Air
	{
		class EventHandlers : DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
	};
    /*
	class ParachuteBase: Helicopter
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
    */
	class Ship: AllVehicles
	{
		class EventHandlers : DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
	};
    class StaticCannon: StaticWeapon
	{
		 class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
    class Tank: LandVehicle
    {
        class EventHandlers : DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
    };
    
};

