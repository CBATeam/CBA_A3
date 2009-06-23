#define COMPONENT strings
#include "\x\cba\addons\main\script_macros.hpp"

#ifdef DEBUG_STRINGS
	#define DEBUG
#endif

#ifdef DEBUGSETTINGS_STRINGS
	#define DEBUGSETTINGS_SETTINGS DEBUG_STRINGS
#endif
#ifndef DEBUGSETTINGS_STRINGS
	#define DEBUGSETTINGS_SETTINGS DEFAULT_DEBUG
#endif
