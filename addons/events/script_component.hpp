#define COMPONENT events
#include "\x\cba_a3\addons\main\script_mod.hpp"

#define KEYS_ARRAY_WRONG ['down', 'up']
#define KEYS_ARRAY ['keydown', 'keyup']

// #define DEBUG_ENABLED_EVENTS

#ifdef DEBUG_ENABLED_EVENTS
	#define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_EVENTS
	#define DEBUG_SETTINGS DEBUG_SETTINGS_EVENTS
#endif

#include "\x\cba_a3\addons\main\script_macros.hpp"
