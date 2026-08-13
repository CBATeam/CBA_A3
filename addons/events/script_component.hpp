#define COMPONENT events
#include "\x\cba\addons\main\script_mod.hpp"

//#define DEBUG_ENABLED_EVENTS

#ifdef DEBUG_ENABLED_EVENTS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_EVENTS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_EVENTS
#endif

#include "\x\cba\addons\main\script_macros.hpp"

#define KEYS_ARRAY_WRONG ['down', 'up']
#define KEYS_ARRAY ['keydown', 'keyup']

// event system
#define EVENT_PVAR CBAs
#define EVENT_PVAR_STR QUOTE(EVENT_PVAR)

#define SYS_SEND_EVENT(params,name,command) EVENT_PVAR = [name, params]; command EVENT_PVAR_STR
#define SEND_EVENT_TO_OTHERS(params,name) SYS_SEND_EVENT(params,name,publicVariable)
#define SEND_EVENT_TO_SERVER(params,name) SYS_SEND_EVENT(params,name,publicVariableServer)
#define SEND_EVENT_TO_CLIENT(params,name,client) SYS_SEND_EVENT(params,name,client publicVariableClient)

// target events
#define TEVENT_PVAR CBAu
#define TEVENT_PVAR_STR QUOTE(TEVENT_PVAR)

#define SEND_TEVENT_TO_SERVER(params,name,targets) TEVENT_PVAR = [name, params, targets]; publicVariableServer TEVENT_PVAR_STR

// turret events
#define TUEVENT_PVAR CBAv
#define TUEVENT_PVAR_STR QUOTE(TUEVENT_PVAR)

#define SEND_TUEVENT_TO_SERVER(params,name,vehicle,turret) TUEVENT_PVAR = [name, params, vehicle, turret]; publicVariableServer TUEVENT_PVAR_STR

// Handlers are never nil: addEventHandler rejects nil and removeEventHandler compacts with
// deleteAt, so the isNil check could never be true. It is not free either, isNil on a string
// looks the variable up by name, which measured ~310ns per handler.
// getVariable supplies the default directly. The [...] param [0, []] this replaces was added to
// stop undefined events erroring (79857b37), which the default covers, and it cost ~158ns more.
#define CALL_EVENT(args,event) {\
    args call _x;\
} forEach +(GVAR(eventNamespace) getVariable [event, []]) // copy array so events can be removed while iterating safely

#define GETOBJ(obj) (if (obj isEqualType grpNull) then {leader obj} else {obj})

#include "\a3\ui_f\hpp\defineDIKCodes.inc"

// key handler system
#define MOUSE_OFFSET 0xF0
#define MOUSE_WHEEL_OFFSET 0xF8 // MOUSE_OFFSET + 8 possible mouse keys
#define USERACTION_OFFSET 0xFA
