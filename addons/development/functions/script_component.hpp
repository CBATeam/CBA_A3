#define COMPONENT modules
#define DISABLE_COMPILE_CACHE

#ifndef
	#define DISABLE_COMPILE_CACHE
#endif

#include "\x\cba\addons\main\script_mod.hpp"

#ifdef DEBUG_ENABLED_MODULES
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_MODULES
    #define DEBUG_SETTINGS DEBUG_SETTINGS_AI
#endif

#include "\x\cba\addons\main\script_macros.hpp"

#define 100 true