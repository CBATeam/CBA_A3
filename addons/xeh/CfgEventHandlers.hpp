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
class Extended_init_Eventhandlers {};

class Extended_firednear_Eventhandlers {};

class Extended_dammaged_Eventhandlers {};

class Extended_hit_Eventhandlers {};

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

// TODO: Consider where these need to be implemented
// Perhaps needs to move to _GAME specific variants?
class DefaultEventhandlers // external - BIS default event handlers in ArmA 2
{
	init = QUOTE(if(isNil 'BIS_Effects_Init') then { call COMPILE_FILE2(\ca\Data\ParticleEffects\SCRIPTS\init.sqf) });
	// Replace fired with firedBis
	delete fired;
	firedBis = "_this call BIS_Effects_EH_Fired"; // Have to convert between XEH _projectile @ _this select 5,  and BIS _projectile @ _this select 6.
	killed = "_this call BIS_Effects_EH_Killed";
};
