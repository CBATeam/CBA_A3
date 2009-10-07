#define COMPONENT common
#include "\x\cba\addons\main\script_mod.hpp"


#ifdef DEBUG_ENABLED_COMMON
	#define DEBUG_MODE_FULL
#else
	#define DEBUG_MODE_MINIMAL
#endif

#ifdef DEBUG_SETTINGS_COMMON
	#define DEBUG_SETTINGS DEBUG_SETTINGS_COMMON
#endif

#include "\x\cba\addons\main\script_macros.hpp"
