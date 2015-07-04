#define COMPONENT diagnostic_logging
#include "\x\cba\addons\main\script_mod.hpp"


#ifdef DEBUG_ENABLED_DIAGNOSTIC_LOGGING
	#define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_DIAGNOSTIC_LOGGING
	#define DEBUG_SETTINGS DEBUG_SETTINGS_DIAGNOSTIC_LOGGING
#endif

#include "\x\cba\addons\main\script_macros.hpp"
