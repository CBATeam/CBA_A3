#define COMPONENT strings
#include "\x\cba\addons\main\script_macros.hpp"

#ifdef DEBUG_STRINGS
	#define DEBUG
#endif

#ifdef DEBUGSETTINGS_STRINGS
	#define DEBUGSETTINGS DEBUGSETTINGS_STRINGS
#else
	#define DEBUGSETTINGS DEFAULT_DEBUGSETTINGS
#endif
