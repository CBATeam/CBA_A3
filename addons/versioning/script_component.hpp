#define COMPONENT versioning
#include "\x\cba\addons\main\script_mod.hpp"

#ifdef DEBUG_ENABLED_VERSIONING
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_VERSIONING
    #define DEBUG_SETTINGS DEBUG_SETTINGS_VERSIONING
#endif

#define DEBUG_SYNCHRONOUS
#include "\x\cba\addons\main\script_macros.hpp"

#define VERSION_DEFAULT [[0, 0, 0], 0]
#define DEPENDENCY_DEFAULT ["", [0, 0, 0], "true"]
