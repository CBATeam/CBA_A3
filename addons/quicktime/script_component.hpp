#define COMPONENT quicktime
#include "\x\cba\addons\main\script_mod.hpp"

//#define DEBUG_MODE_FULL
//#define DISABLE_COMPILE_CACHE
//#define DEBUG_ENABLED_quicktime

#ifdef DEBUG_ENABLED_QUICKTIME
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_QUICKTIME
    #define DEBUG_SETTINGS DEBUG_SETTINGS_QUICKTIME
#endif

#define DEBUG_SYNCHRONOUS
#include "\x\cba\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineResincl.inc"

