#define COMPONENT main

// Set a default debug mode for the component here (See documentation on how to default to each of the modes).

#include "script_macros.hpp"

#ifdef DEBUG_MAIN
	#define DEBUG
#endif

#ifdef DEBUGSETTINGS_MAIN
	#define DEBUGSETTINGS DEBUGSETTINGS_MAIN
#else
	#define DEBUGSETTINGS DEFAULT_DEBUGSETTINGS
#endif
