#define COMPONENT actions
#include "\x\cba\addons\main\script_macros.hpp"

#ifdef DEBUG_ACTIONS
	#define DEBUG
#endif

#ifdef DEBUG_ACTIONS_SETTINGS
	#define DEBUG_SETTINGS DEBUG_ACTIONS_SETTINGS
#endif
#ifndef DEBUG_ACTIONS_SETTINGS
	#define DEBUG_SETTINGS DEFAULT_DEBUG_SETTINGS
#endif
