#define COMPONENT accessory
#include "\x\cba\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define DEBUG_ENABLED_ACCESSORY

#ifdef DEBUG_ENABLED_ACCESSORY
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_ACCESSORY
    #define DEBUG_SETTINGS DEBUG_SETTINGS_ACCESSORY
#endif

#include "\x\cba\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineDIKCodes.inc"
