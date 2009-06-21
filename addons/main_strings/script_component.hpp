#define COMPONENT main_strings
#include "\x\cba\addons\main\script_macros.hpp"

#ifdef DEBUG_MAIN_STRINGS
	#define DEBUG
#endif

#ifdef DEBUG_MAIN_STRINGS_SETTINGS
	#define DEBUG_SETTINGS DEBUG_MAIN_STRINGS_SETTINGS
#endif
#ifndef DEBUG_MAIN_STRINGS_SETTINGS
	#define DEBUG_SETTINGS DEFAULT_DEBUG_SETTINGS
#endif
