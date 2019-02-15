#define COMPONENT common
#include "\x\cba\addons\main\script_mod.hpp"

#define SKIP_FUNCTION_HEADER
#define SKIP_SCRIPT_NAME

#ifdef DEBUG_ENABLED_COMMON
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_COMMON
    #define DEBUG_SETTINGS DEBUG_SETTINGS_COMMON
#endif

#include "\x\cba\addons\main\script_macros.hpp"

#define DUMMY_POSITION [-1000, -1000, 0]
