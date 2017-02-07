#define COMPONENT static_settings_addon
#include "\x\cba\addons\main\script_mod.hpp"

//#define DEBUG_ENABLED_STATIC_SETTINGS_ADDON

#ifdef DEBUG_ENABLED_STATIC_SETTINGS_ADDON
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_STATIC_SETTINGS_ADDON
    #define DEBUG_SETTINGS DEBUG_SETTINGS_STATIC_SETTINGS_ADDON
#endif

#include "\x\cba\addons\main\script_macros.hpp"

#define PATH_SETTINGS_FILE_PBO QPATHTOF(userconfig\cba\settings.sqf)
