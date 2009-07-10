#define COMPONENT hashes


#ifdef DEBUG_ENABLED_HASHES
	#define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_HASHES
	#undef DEBUG_SETTINGS
	#define DEBUG_SETTINGS DEBUG_SETTINGS_HASHES
#endif

#include "\x\cba\addons\main\script_macros.hpp"
