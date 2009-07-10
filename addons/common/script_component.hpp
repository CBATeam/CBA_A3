#define COMPONENT common


#ifdef DEBUG_ENABLED_COMMON
	#define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_COMMON
	#undef DEBUG_SETTINGS
	#define DEBUG_SETTINGS DEBUG_SETTINGS_COMMON
#endif

#include "\x\cba\addons\main\script_macros.hpp"
