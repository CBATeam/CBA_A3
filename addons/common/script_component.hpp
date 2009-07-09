#define COMPONENT common
#include "\x\cba\addons\main\script_macros.hpp"

#ifdef DEBUG_COMMON
	#define DEBUG_MODE_FULL
#endif

#ifdef DEBUGSETTINGS_COMMON
	#define DEBUGSETTINGS DEBUGSETTINGS_COMMON
#else
	#define DEBUGSETTINGS DEFAULT_DEBUGSETTINGS
#endif
