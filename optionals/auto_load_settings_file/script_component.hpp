#define COMPONENT auto_load_settings_file
#include "\x\cba\addons\main\script_mod.hpp"

//#define DEBUG_ENABLED_AUTO_LOAD_SETTINGS_FILE

#ifdef DEBUG_ENABLED_AUTO_LOAD_SETTINGS_FILE
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_AUTO_LOAD_SETTINGS_FILE
    #define DEBUG_SETTINGS DEBUG_SETTINGS_AUTO_LOAD_SETTINGS_FILE
#endif

#include "\x\cba\addons\main\script_macros.hpp"

#define PATH_SETTINGS_FILE "userconfig\cba\settings.sqf"
