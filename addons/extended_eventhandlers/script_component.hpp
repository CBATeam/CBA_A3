#define COMPONENT extended_eventhandlers
#include "\x\cba\addons\main\script_macros.hpp"

#ifdef DEBUG_XEH
	#define DEBUG
#endif

#ifdef DEBUG_XEH_SETTINGS
	#define DEBUG_SETTINGS DEBUG_XEH_SETTINGS
#endif
#ifndef DEBUG_XEH_SETTINGS
	#define DEBUG_SETTINGS DEFAULT_DEBUG_SETTINGS
#endif
