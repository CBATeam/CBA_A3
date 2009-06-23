#define COMPONENT events
#include "\x\cba\addons\common\script_macros.hpp"

#ifdef DEBUG_MAIN_EVENTS
	#define DEBUG
#endif

#ifdef DEBUG_MAIN_EVENTS_SETTINGS
	#define DEBUG_SETTINGS DEBUG_MAIN_EVENTS_SETTINGS
#endif
#ifndef DEBUG_MAIN_EVENTS_SETTINGS
	#define DEBUG_SETTINGS DEFAULT_DEBUG_SETTINGS
#endif
