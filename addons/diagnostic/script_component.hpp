#define COMPONENT diagnostic
#include "\x\cba\addons\main\script_macros.hpp"

#ifdef DEBUG_DIAGNOSTIC
	#define DEBUG
#endif

#ifdef DEBUGSETTINGS_DIAGNOSTIC
	#define DEBUGSETTINGS DEBUGSETTINGS_DIAGNOSTIC
#endif
#ifndef DEBUGSETTINGS_DIAGNOSTIC
	#define DEBUGSETTINGS DEFAULT_DEBUG
#endif
