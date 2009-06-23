#define COMPONENT events
#include "\x\cba\addons\main\script_macros.hpp"

#ifdef DEBUG_EVENTS
	#define DEBUG
#endif

#ifdef DEBUGSETTINGS_EVENTS
	#define DEBUGSETTINGS_SETTINGS DEBUG_EVENTS
#endif
#ifndef DEBUGSETTINGS_EVENTS
	#define DEBUGSETTINGS_SETTINGS DEFAULT_DEBUG
#endif
