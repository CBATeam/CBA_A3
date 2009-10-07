#define COMPONENT diagnostic
#include "\x\cba\addons\main\script_mod.hpp"


#ifdef DEBUG_ENABLED_DIAGNOSTIC
	#define DEBUG_MODE_FULL
#else
	#define DEBUG_MODE_MINIMAL
#endif

#ifdef DEBUG_SETTINGS_DIAGNOSTIC
	#define DEBUG_SETTINGS DEBUG_SETTINGS_DIAGNOSTIC
#endif

#include "\x\cba\addons\main\script_macros.hpp"
