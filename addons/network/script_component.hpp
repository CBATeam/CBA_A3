#define COMPONENT network
#include "\x\cba\addons\main\script_macros.hpp"

#ifdef DEBUG_NETWORK
	#define DEBUG
#endif

#ifdef DEBUGSETTINGS_NETWORK
	#define DEBUGSETTINGS DEBUGSETTINGS_NETWORK
#endif
#ifndef DEBUGSETTINGS_NETWORK
	#define DEBUGSETTINGS DEFAULT_DEBUG
#endif
