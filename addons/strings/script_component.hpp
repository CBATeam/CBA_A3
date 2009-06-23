#define COMPONENT strings
#include "\x\cba\addons\main\script_macros.hpp"

#ifdef DEBUG_STRINGS
	#define DEBUG
#endif

#ifdef DEBUGSETTINGS_STRINGS
	#define DEBUGSETTINGS DEBUGSETTINGS_STRINGS
#endif
#ifndef DEBUGSETTINGS_STRINGS
	#define DEBUGSETTINGS DEFAULT_DEBUG
#endif
