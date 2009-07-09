#define COMPONENT hashes
#include "\x\cba\addons\main\script_macros.hpp"

#ifdef DEBUG_HASHES
	#define DEBUG_MODE_FULL
#endif

#ifdef DEBUGSETTINGS_HASHES
	#define DEBUGSETTINGS DEBUGSETTINGS_HASHES
#else
	#define DEBUGSETTINGS DEFAULT_DEBUGSETTINGS
#endif
