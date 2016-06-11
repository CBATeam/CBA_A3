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
#define EVENT_PVAR CBAr
#define EVENT_PVAR_STR QUOTE(EVENT_PVAR)

#define SYS_SEND_EVENT(params,name,command) EVENT_PVAR = [name, params]; command EVENT_PVAR_STR
#define SEND_EVENT_TO_OTHERS(params,name) SYS_SEND_EVENT(params,name,publicVariable)
#define SEND_EVENT_TO_SERVER(params,name) SYS_SEND_EVENT(params,name,publicVariableServer)
#define SEND_EVENT_TO_CLIENT(params,name,client) SYS_SEND_EVENT(params,name,client publicVariableClient)

// target events
#define TEVENT_PVAR CBAt
#define TEVENT_PVAR_STR QUOTE(TEVENT_PVAR)

#define SEND_TEVENT_TO_SERVER(params,name,targets) TEVENT_PVAR = [name, params, targets]; publicVariableServer TEVENT_PVAR_STR

#define CALL_EVENT(params,event) {\
    if !(isNil "_x") then {\
        private _thisType = event;\
        _x params ["_thisFnc", "_thisArgs", "_thisId"];\
        params call _thisFnc;\
    };\
} forEach (GVAR(eventNamespace) getVariable event)

#define GETOBJ(obj) (if (obj isEqualType grpNull) then {leader obj} else {obj})

#include "\a3\editor_f\Data\Scripts\dikCodes.h"
