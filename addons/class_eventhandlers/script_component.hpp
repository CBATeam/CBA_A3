#define COMPONENT class_eventhandlers
#include "\x\cba\addons\main\script_mod.hpp"

#ifdef DEBUG_ENABLED_CLASS_EVENTHANDLERS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_ENABLED_CLASS_EVENTHANDLERS
    #define DEBUG_SETTINGS DEBUG_ENABLED_CLASS_EVENTHANDLERS
#endif

#include "\x\cba\addons\main\script_macros.hpp"

// case sensitve - lower case
#define SUPPORTED_EH [ \
    "animchanged", \
    "animdone", \
    "animstatechanged", \
    "containerclosed", \
    "containeropened", \
    "controlsshifted", \
    "dammaged", \
    "engine", \
    "epecontact", \
    "epecontactend", \
    "epecontactstart", \
    "explosion", \
    "fired", \
    "firednear", \
    "fuel", \
    "gear", \
    "getin", \
    "getout", \
    "handleheal", \
    "handlerating", \
    "handlescore", \
    "hit", \
    "hitpart", \
    "incomingmissile", \
    "inventoryclosed", \
    "inventoryopened", \
    "killed", \
    "landedtouchdown", \
    "landedstopped", \
    "local", \
    "put", \
    "respawn", \
    "seatswitched", \
    "soundplayed", \
    "take", \
    "tasksetascurrent", \
    "weaponassembled", \
    "weapondisassembled", \
    "weapondeployed", \
    "weaponrested" \
]

#define EVENTHANDLERS(type,class) (missionNamespace getVariable [format [QGVAR(%1:%2), type, class], []])
#define SETEVENTHANDLERS(type,class,events) (missionNamespace setVariable [format [QGVAR(%1:%2), type, class], events])
