#define COMPONENT hashes
#include "\x\cba\addons\main\script_macros.hpp"

#ifdef DEBUG_HASHES
	#define DEBUG
#endif

#ifdef DEBUGSETTINGS_HASHES
	#define DEBUGSETTINGS_SETTINGS DEBUG_HASHES
#endif
#ifndef DEBUGSETTINGS_HASHES
	#define DEBUGSETTINGS_SETTINGS DEFAULT_DEBUG
#endif
