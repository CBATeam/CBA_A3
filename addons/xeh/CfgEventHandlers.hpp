// We'll need this one for backwards compatibility with third-party addons
// that expect the class to exist
class Extended_EventHandlers
{
    EXTENDED_EVENTHANDLERS
};


// The PreStart handlers run once when the game is started
// this could be used to precompile functions.
class Extended_PreStart_EventHandlers {};

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
class Extended_AnimChanged_EventHandlers {};
class Extended_AnimDone_EventHandlers {};
class Extended_AnimStateChanged_EventHandlers {};
class Extended_ContainerClosed_EventHandlers {};
class Extended_ContainerOpened_EventHandlers {};
class Extended_ControlsShifted_EventHandlers {};
class Extended_Dammaged_EventHandlers {};
class Extended_Engine_EventHandlers {};
class Extended_EpeContact_EventHandlers {};
class Extended_EpeContactEnd_EventHandlers {};
class Extended_EpeContactStart_EventHandlers {};
class Extended_Explosion_EventHandlers {};
class Extended_Fired_EventHandlers {};    // Backwards compatibility, uses XEH notation
class Extended_FiredBIS_EventHandlers {}; // New fired EH, uses BIS notation
class Extended_FiredNear_EventHandlers {};
class Extended_Fuel_EventHandlers {};
class Extended_Gear_EventHandlers {};
class Extended_HandleDamage_EventHandlers {}; // Not implemented yet
class Extended_HandleHeal_EventHandlers {};   // Not implemented yet
class Extended_Hit_EventHandlers {};
class Extended_HitPart_EventHandlers {};
class Extended_Init_EventHandlers {};
class Extended_IncomingMissile_EventHandlers {};
class Extended_InventoryClosed_EventHandlers {};
class Extended_InventoryOpened_EventHandlers {};
class Extended_Killed_EventHandlers {};
class Extended_LandedTouchDown_EventHandlers {};
class Extended_LandedStopped_EventHandlers {};
class Extended_Local_EventHandlers {};
/*
// Don't work
class Extended_MPHit_EventHandlers {};
class Extended_MPKilled_EventHandlers {};
class Extended_MPRespawn_EventHandlers {};
*/
class Extended_Put_EventHandlers {};
class Extended_Take_EventHandlers {};
class Extended_SeatSwitched_EventHandlers {};
class Extended_SoundPlayed_EventHandlers {};
class Extended_WeaponAssembled_EventHandlers {};
class Extended_WeaponDisassembled_EventHandlers {};

class Extended_GetIn_EventHandlers
{
    // Default Extended Event Handlers: Custom GetInMan event
    class AllVehicles
    {
        class SLX_GetInMan
        {
                scope     = public;
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
                scope     = public;
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
                scope     = public;
                respawn  = "_this call SLX_XEH_EH_RespawnInit";
        };
    };
};

class DefaultEventhandlers;
class Default_Extended_Eventhandlers: DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
