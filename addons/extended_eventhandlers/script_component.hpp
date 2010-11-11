#define COMPONENT eventhandlers

#include "\x\cba\addons\extended_eventhandlers\script_mod.hpp"

// #define DEBUG_ENABLED_XEH

#ifdef DEBUG_ENABLED_XEH
	#define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_XEH
	#define DEBUG_SETTINGS DEBUG_SETTINGS_XEH
#endif

#define XEH_LOG(MESSAGE) diag_log [diag_frameNo, diag_tickTime, time, MESSAGE]
#define INITPOST [_unit, "Extended_InitPost_EventHandlers"]
#define XEH_EVENTS "Fired", "AnimChanged", "AnimStateChanged", "Dammaged", "Engine", "FiredNear", "Fuel", "Gear", "GetIn", "GetOut", "IncomingMissile", "Hit", "Killed", "LandedTouchDown", "LandedStopped"


#include "\x\cba\addons\extended_eventhandlers\script_macros_common.hpp"
