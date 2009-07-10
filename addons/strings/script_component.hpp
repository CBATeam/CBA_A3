#define COMPONENT strings


#ifdef DEBUG_ENABLED_STRINGS
	#define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_STRINGS
	#undef DEBUG_SETTINGS
	#define DEBUG_SETTINGS DEBUG_SETTINGS_STRINGS
#endif

#include "\x\cba\addons\main\script_macros.hpp"
