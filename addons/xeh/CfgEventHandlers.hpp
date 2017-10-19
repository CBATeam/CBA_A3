class XEH_CLASS_BASE {
    EXTENDED_EVENTHANDLERS
};

class XEH_CLASS: XEH_CLASS_BASE {}; // bwc

class DefaultEventhandlers {
    class XEH_CLASS: XEH_CLASS_BASE {};
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
class Extended_GetIn_EventHandlers {};
class Extended_GetInMan_EventHandlers {};
class Extended_GetOut_EventHandlers {};
class Extended_GetOutMan_EventHandlers {};
//class Extended_HandleDamage_EventHandlers {}; // Not implemented yet
//class Extended_HandleHeal_EventHandlers {};   // Not implemented yet
class Extended_Hit_EventHandlers {};
class Extended_HitPart_EventHandlers {};
class Extended_IncomingMissile_EventHandlers {};
class Extended_Init_EventHandlers {};
class Extended_InventoryClosed_EventHandlers {};
class Extended_InventoryOpened_EventHandlers {};
class Extended_Killed_EventHandlers {};
class Extended_LandedStopped_EventHandlers {};
class Extended_LandedTouchDown_EventHandlers {};
class Extended_Local_EventHandlers {};

// Don't work
/*
class Extended_MPHit_EventHandlers {};
class Extended_MPKilled_EventHandlers {};
class Extended_MPRespawn_EventHandlers {};
*/

class Extended_Put_EventHandlers {};
class Extended_Respawn_EventHandlers {};
class Extended_SeatSwitched_EventHandlers {};
class Extended_SeatSwitchedMan_EventHandlers {};
class Extended_SoundPlayed_EventHandlers {};
class Extended_Take_EventHandlers {};
class Extended_WeaponAssembled_EventHandlers {};
class Extended_WeaponDisassembled_EventHandlers {};
class Extended_Reloaded_EventHandlers {};
class Extended_FiredMan_EventHandlers {};
class Extended_TurnIn_EventHandlers {};
class Extended_TurnOut_EventHandlers {};
class Extended_Deleted_EventHandlers {};

// display xeh
class Extended_DisplayLoad_EventHandlers {
    class Display3DEN {
        ADDON = QUOTE(call (uiNamespace getVariable 'FUNC(initDisplay3DEN)'));
    };
};
class Extended_DisplayUnload_EventHandlers {};
