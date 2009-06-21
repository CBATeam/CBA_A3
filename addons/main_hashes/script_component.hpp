#define COMPONENT main_hashes
#include "\x\cba\addons\main\script_macros.hpp"

#ifdef DEBUG_MAIN_HASHES
	#define DEBUG
#endif

#ifdef DEBUG_MAIN_HASHES_SETTINGS
	#define DEBUG_SETTINGS DEBUG_MAIN_HASHES_SETTINGS
#endif
#ifndef DEBUG_MAIN_HASHES_SETTINGS
	#define DEBUG_SETTINGS DEFAULT_DEBUG_SETTINGS
#endif
