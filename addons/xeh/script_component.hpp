#define COMPONENT xeh

#include "\x\cba\addons\main\script_mod.hpp"

//#define DEBUG_ENABLED_XEH

#ifdef DEBUG_ENABLED_XEH
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_XEH
    #define DEBUG_SETTINGS DEBUG_SETTINGS_XEH
#endif

#include "\x\cba\addons\main\script_macros.hpp"

#define XEH_LOG(msg) if (!SLX_XEH_DisableLogging) then { diag_log [diag_frameNo, diag_tickTime, time, msg] }

#define SYS_EVENTHANDLERS(type,class) format [QGVAR(%1:%2), type, class]
#define EVENTHANDLERS(type,class) (missionNamespace getVariable [SYS_EVENTHANDLERS(type,class), []])
#define SETEVENTHANDLERS(type,class,events) (missionNamespace setVariable [SYS_EVENTHANDLERS(type,class), events])

// For any class that does not comply with XEH or has at least one incompatible descendant.
#define ISINCOMP(class) !isNil {GVAR(incompatible) getVariable class}
#define SETINCOMP(class) GVAR(incompatible) setVariable [class, true]

// Event handler variables set.
#define ISPROCESSED(obj) (obj getVariable [QGVAR(isProcessed), false])
#define SETPROCESSED(obj) obj setVariable [QGVAR(isProcessed), true]

// Init and InitPost events done.
#define ISINITIALIZED(obj) (obj getVariable [QGVAR(isInitialized), false])
#define SETINITIALIZED(obj) obj setVariable [QGVAR(isInitialized), true]

#define XEH_FORMAT_CONFIG_NAME(name) format ["Extended_%1_EventHandlers", name]

#define ISKINDOF(object,classname,allowInherit,excluded) ((allowInherit || {typeOf object == classname}) && {{object isKindOf _x} count (excluded) == 0})

#include "script_xeh.hpp"

#define XEH_MAIN_CONFIGS [configFile, campaignConfigFile, missionConfigFile]

#undef XEH_ENABLED
#define XEH_ENABLED class EventHandlers { class XEH_CLASS: XEH_CLASS_BASE {}; }; SLX_XEH_DISABLED = 0

#define XEH_EVENTS \
    "AnimChanged", \
    "AnimStateChanged", \
    "AnimDone", \
    "ContainerClosed", \
    "ContainerOpened", \
    "ControlsShifted", \
    "Dammaged", \
    "Engine", \
    "EpeContact", \
    "EpeContactEnd", \
    "EpeContactStart", \
    "Explosion", \
    "Fired", \
    "FiredBis", \
    "FiredNear", \
    "Fuel", \
    "Gear", \
    "GetIn", \
    "GetInMan", \
    "GetOut", \
    "GetOutMan", \
    "HandleHeal", \
    "Hit", \
    "HitPart", \
    "IncomingMissile", \
    "Init", \
    "InitPost", \
    "InventoryClosed", \
    "InventoryOpened", \
    "Killed", \
    "LandedTouchDown", \
    "LandedStopped", \
    "Local", \
    "Respawn", \
    "Put", \
    "Take", \
    "SeatSwitched", \
    "SeatSwitchedMan", \
    "SoundPlayed", \
    "WeaponAssembled", \
    "WeaponDisassembled", \
    "WeaponDeployed", \
    "WeaponRested", \
    "Reloaded"
