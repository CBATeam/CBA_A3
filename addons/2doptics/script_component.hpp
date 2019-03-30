#define COMPONENT 2doptics
#include "\x\cba\addons\main\script_mod.hpp"

//#define DEBUG_MODE_FULL
//#define DISABLE_COMPILE_CACHE
//#define DEBUG_ENABLED_2DOPTICS

#ifdef DEBUG_ENABLED_2DOPTICS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_2DOPTICS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_2DOPTICS
#endif

#define DEBUG_SYNCHRONOUS
#include "\x\cba\addons\main\script_macros.hpp"
