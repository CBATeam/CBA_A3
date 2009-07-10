#define COMPONENT main

// Set a default debug mode for the component here (See documentation on how to default to each of the modes).



#ifdef DEBUG_ENABLED_MAIN
	#define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_MAIN
	#undef DEBUG_SETTINGS
	#define DEBUG_SETTINGS DEBUG_SETTINGS_MAIN
#endif

#include "script_macros.hpp"
