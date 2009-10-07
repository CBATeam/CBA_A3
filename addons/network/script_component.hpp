#define COMPONENT network
#include "\x\cba\addons\main\script_mod.hpp"


#ifdef DEBUG_ENABLED_NETWORK
	#define DEBUG_MODE_FULL
#else
	#define DEBUG_MODE_MINIMAL
#endif

#ifdef DEBUG_SETTINGS_NETWORK
	#define DEBUG_SETTINGS DEBUG_SETTINGS_NETWORK
#endif

#include "\x\cba\addons\main\script_macros.hpp"
