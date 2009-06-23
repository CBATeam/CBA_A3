#define COMPONENT network
#include "\x\cba\addons\main\script_macros.hpp"

#ifdef DEBUG_NETWORK
	#define DEBUG
#endif

#ifdef DEBUGSETTINGS_NETWORK
	#define DEBUGSETTINGS_SETTINGS DEBUG_NETWORK
#endif
#ifndef DEBUGSETTINGS_NETWORK
	#define DEBUGSETTINGS_SETTINGS DEFAULT_DEBUG
#endif
