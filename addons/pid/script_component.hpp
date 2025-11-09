#define COMPONENT pid
#include "\x\cba\addons\main\script_mod.hpp"

// #define DISABLE_COMPILE_CACHE
// #define PID_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_PID
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_PID
    #define DEBUG_SETTINGS DEBUG_SETTINGS_PID
#endif

#include "\x\cba\addons\main\script_macros.hpp"
