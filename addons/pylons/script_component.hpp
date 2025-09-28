#define COMPONENT pylons
#include "\x\cba\addons\main\script_mod.hpp"

#ifdef DEBUG_ENABLED_AI
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_AI
    #define DEBUG_SETTINGS DEBUG_SETTINGS_PYLONS
#endif

#include "\x\cba\addons\main\script_macros.hpp"

#define JETTISON_MODE_ALL 0
#define JETTISON_MODE_SELECTED 1
#define JETTISON_MODE_DOGFIGHT 2
