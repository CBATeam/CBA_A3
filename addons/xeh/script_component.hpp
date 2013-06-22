#define COMPONENT xeh

#include "\x\cba_a3\addons\main\script_mod.hpp"

// #define DEBUG_ENABLED_XEH

#ifdef DEBUG_ENABLED_XEH
	#define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_XEH
	#define DEBUG_SETTINGS DEBUG_SETTINGS_XEH
#endif

#define XEH_LOG(MESSAGE) if !(SLX_XEH_DisableLogging) then { diag_log [diag_frameNo, diag_tickTime, time, MESSAGE] }
#define XEH_EVENTS "AnimChanged", "AnimStateChanged", "AnimDone", "Dammaged", "Engine", \
	"Fired", "FiredNear", "Fuel", "Gear", "GetIn", "GetOut", "Hit", \
	"IncomingMissile", "Killed", "LandedTouchDown", "LandedStopped", \
	"Respawn" //, "MPHit", "MPKilled", "MPRespawn"
//"HandleDamage", "HandleHealing"
#define XEH_CUSTOM_EVENTS "GetInMan", "GetOutMan", "FiredBis"


#include "\x\cba_a3\addons\main\script_macros.hpp"
