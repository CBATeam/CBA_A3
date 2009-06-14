#define COMPONENT keys
#include "\x\cba\addons\main\script_macros.hpp"

#ifdef DEBUG_KEYS
	#define DEBUG
#endif

#ifdef DEBUG_KEYS_SETTINGS
	#define DEBUG_SETTINGS DEBUG_KEYS_SETTINGS
#endif
#ifndef DEBUG_KEYS_SETTINGS
	#define DEBUG_SETTINGS DEFAULT_DEBUG_SETTINGS
#endif
