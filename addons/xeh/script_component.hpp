#define COMPONENT xeh
#include "\x\cba\addons\main\script_mod.hpp"

//#define DEBUG_ENABLED_XEH

#ifdef DEBUG_ENABLED_XEH
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_XEH
    #define DEBUG_SETTINGS DEBUG_SETTINGS_XEH
#endif

#define DEBUG_SYNCHRONOUS
#include "\x\cba\addons\main\script_macros.hpp"

#define XEH_LOG(msg) if (!SLX_XEH_DisableLogging) then { INFO_2("%1 %2",[ARR_3(diag_frameNo,diag_tickTime,time)],msg); }

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

#undef XEH_ENABLED
#define XEH_ENABLED class EventHandlers {class XEH_CLASS: XEH_CLASS_BASE {};}; SLX_XEH_DISABLED = 0

#define XEH_EVENTS \
    "AnimChanged", \
    "AnimDone", \
    "AnimStateChanged", \
    "CargoLoaded", \
    "CargoUnloaded", \
    "ContainerClosed", \
    "ContainerOpened", \
    "ControlsShifted", \
    "Dammaged", \
    "Deleted", \
    "Disassembled", \
    "Engine", \
    "EpeContact", \
    "EpeContactEnd", \
    "EpeContactStart", \
    "Explosion", \
    "Fired", \
    "FiredBis", \
    "FiredMan", \
    "FiredNear", \
    "Fuel", \
    "Gear", \
    "GestureChanged", \
    "GestureDone", \
    "GetIn", \
    "GetInMan", \
    "GetOut", \
    "GetOutMan", \
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
    "OpticsModeChanged", \
    "OpticsSwitch", \
    "Put", \
    "Reloaded", \
    "Respawn", \
    "RopeAttach", \
    "RopeBreak", \
    "SeatSwitched", \
    "SeatSwitchedMan", \
    "SlotItemChanged", \
    "SoundPlayed", \
    "Suppressed", \
    "Take", \
    "TurnIn", \
    "TurnOut", \
    "VisionModeChanged", \
    "WeaponAssembled", \
    "WeaponDisassembled", \
    "WeaponDeployed", \
    "WeaponRested"
