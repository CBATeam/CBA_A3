#define COMPONENT statemachine
#include "\x\cba\addons\main\script_mod.hpp"

// #define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_STATEMACHINE
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_STATEMACHINE
    #define DEBUG_SETTINGS DEBUG_SETTINGS_STATEMACHINE
#endif

#include "\x\cba\addons\main\script_macros.hpp"

#define TRANSITIONS(var) (var + "_transitions")
#define ONSTATE(var) (var + "_onState")
