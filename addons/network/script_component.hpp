#define COMPONENT network
#include "\x\cba\addons\main\script_macros.hpp"

#ifdef DEBUG_MAIN_NETWORK
	#define DEBUG
#endif

#ifdef DEBUG_MAIN_NETWORK_SETTINGS
	#define DEBUG_SETTINGS DEBUG_MAIN_NETWORK_SETTINGS
#endif
#ifndef DEBUG_MAIN_NETWORK_SETTINGS
	#define DEBUG_SETTINGS DEFAULT_DEBUG_SETTINGS
#endif
