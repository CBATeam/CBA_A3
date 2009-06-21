#define COMPONENT main_diagnostic
#include "\x\cba\addons\main\script_macros.hpp"

#ifdef DEBUG_MAIN_DIAGNOSTIC
	#define DEBUG
#endif

#ifdef DEBUG_MAIN_DIAGNOSTIC_SETTINGS
	#define DEBUG_SETTINGS DEBUG_MAIN_DIAGNOSTIC_SETTINGS
#endif
#ifndef DEBUG_MAIN_DIAGNOSTIC_SETTINGS
	#define DEBUG_SETTINGS DEFAULT_DEBUG_SETTINGS
#endif
