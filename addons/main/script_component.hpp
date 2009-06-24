#define COMPONENT main
#include "script_macros.hpp"

#ifdef DEBUG_MAIN
	#define DEBUG
#endif

#ifdef DEBUGSETTINGS_MAIN
	#define DEBUGSETTINGS DEBUGSETTINGS_MAIN
#else
	#define DEBUGSETTINGS DEFAULT_DEBUGSETTINGS
#endif
