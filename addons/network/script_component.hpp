#define COMPONENT network
#include "\x\cba\addons\main\script_macros.hpp"

#ifdef DEBUG_NETWORK
	#define DEBUG_MODE_FULL
#endif

#ifdef DEBUGSETTINGS_NETWORK
	#define DEBUGSETTINGS DEBUGSETTINGS_NETWORK
#else
	#define DEBUGSETTINGS DEFAULT_DEBUGSETTINGS
#endif
