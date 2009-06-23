#define COMPONENT hashes
#include "\x\cba\addons\main\script_macros.hpp"

#ifdef DEBUG_HASHES
	#define DEBUG
#endif

#ifdef DEBUGSETTINGS_HASHES
	#define DEBUGSETTINGS DEBUGSETTINGS_HASHES
#endif
#ifndef DEBUGSETTINGS_HASHES
	#define DEBUGSETTINGS DEFAULT_DEBUGSETTINGS
#endif
