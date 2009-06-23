#define COMPONENT main
#include "script_macros.hpp"

#ifdef DEBUG_MAIN
	#define DEBUG
#endif

#ifdef DEBUG_MAIN_SETTINGS
	#define DEBUG_SETTINGS DEBUG_MAIN_SETTINGS
#endif
#ifndef DEBUG_MAIN_SETTINGS
	#define DEBUG_SETTINGS DEFAULT_DEBUG_SETTINGS
#endif
