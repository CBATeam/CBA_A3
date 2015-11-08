#define COMPONENT xeh

#include "\x\cba\addons\main\script_mod.hpp"

// #define DEBUG_ENABLED_XEH

#ifdef DEBUG_ENABLED_XEH
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_XEH
    #define DEBUG_SETTINGS DEBUG_SETTINGS_XEH
#endif

#define XEH_LOG(MESSAGE) if !(SLX_XEH_DisableLogging) then { [QUOTE(PREFIX), QUOTE(COMPONENT), MESSAGE, CBA_LOGLEVEL_INFO, [CBA_fnc_diagLogWriter]] call CBA_fnc_logDynamic }
#define XEH_EVENTS "AnimChanged", "AnimStateChanged", "AnimDone", \
    "ContainerClosed", "ContainerOpened", "ControlsShifted", "Dammaged", \
    "Engine", "EpeContact", "EpeContactEnd", "EpeContactStart", \
    "Explosion", "Fired", "FiredNear", "Fuel", "Gear", "GetIn", "GetOut", \
    /* "HandleDamage", */ "HandleHeal", "Hit", "HitPart", "IncomingMissile", \
    "InventoryClosed", "InventoryOpened", \
    "Killed", "LandedTouchDown", "LandedStopped", "Local", /* "MPHit", */ \
    /* "MPKilled", "MPRespawn", */ "Respawn", "Put", "Take", "SeatSwitched", \
    "SoundPlayed", "WeaponAssembled", "WeaponDisassembled"
#define XEH_CUSTOM_EVENTS "GetInMan", "GetOutMan", "FiredBis"


#include "\x\cba\addons\main\script_macros.hpp"
