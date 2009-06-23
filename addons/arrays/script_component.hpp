#define COMPONENT arrays
#include "\x\cba\addons\main\script_macros.hpp"

#ifdef DEBUG_ARRAYS
	#define DEBUG
#endif

#ifdef DEBUGSETTINGS_ARRAYS
	#define DEBUGSETTINGS_SETTINGS DEBUG_ARRAYS
#endif
#ifndef DEBUGSETTINGS_ARRAYS
	#define DEBUGSETTINGS_SETTINGS DEFAULT_DEBUG
#endif
