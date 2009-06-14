#ifndef CBA_MAIN_SCRIPT_COMPONENT_INCLUDED
#define CBA_MAIN_SCRIPT_COMPONENT_INCLUDED

#define COMPONENT main
#include "script_macros.hpp"

#endif

#ifdef DEBUG_MAIN
	#define DEBUG
#endif

#ifdef DEBUG_MAIN_SETTINGS
	#define DEBUG_SETTINGS DEBUG_MAIN_SETTINGS
#endif
#ifndef DEBUG_MAIN_SETTINGS
	#define DEBUG_SETTINGS DEFAULT_DEBUG_SETTINGS
#endif
