#define COMPONENT arrays
#include "\x\cba\addons\main\script_macros.hpp"

#ifdef DEBUG_ARRAYS
	#define DEBUG_MODE_FULL
#endif

#ifdef DEBUGSETTINGS_ARRAYS
	#define DEBUGSETTINGS DEBUGSETTINGS_ARRAYS
#else
	#define DEBUGSETTINGS DEFAULT_DEBUGSETTINGS
#endif
