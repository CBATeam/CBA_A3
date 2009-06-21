#define COMPONENT main_eventhandlers
#include "\x\cba\addons\main\script_macros.hpp"

#ifdef DEBUG_MAIN_EVENTHANDLERS
	#define DEBUG
#endif

#ifdef DEBUG_MAIN_EVENTHANDLERS_SETTINGS
	#define DEBUG_SETTINGS DEBUG_MAIN_EVENTHANDLERS_SETTINGS
#endif
#ifndef DEBUG_MAIN_EVENTHANDLERS_SETTINGS
	#define DEBUG_SETTINGS DEFAULT_DEBUG_SETTINGS
#endif
