#define COMPONENT main

// Set a default debug mode for the component.
#ifndef DEBUG_MODE_OFF
#ifndef DEBUG_MODE_MINIMAL
#undef DEBUG_MODE_NORMAL
#define DEBUG_MODE_NORMAL
#endif
#endif

#include "script_macros.hpp"

#ifdef DEBUG_MAIN
	#define DEBUG
#endif

#ifdef DEBUGSETTINGS_MAIN
	#define DEBUGSETTINGS DEBUGSETTINGS_MAIN
#else
	#define DEBUGSETTINGS DEFAULT_DEBUGSETTINGS
#endif
