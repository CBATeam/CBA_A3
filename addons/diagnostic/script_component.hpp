#define COMPONENT diagnostic
#include "\x\cba\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_DIAGNOSTIC
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_DIAGNOSTIC
    #define DEBUG_SETTINGS DEBUG_SETTINGS_DIAGNOSTIC
#endif

#include "\x\cba\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\a3\ui_f\hpp\defineResincl.inc"
// #include "\a3\ui_f\hpp\defineResinclDesign.inc" // moved to sqf to handle undef error

#define IDC_DEBUGCONSOLE_PREV 90110
#define IDC_DEBUGCONSOLE_NEXT 90111

#define ASCII_TAB 9
#define ASCII_SPACE 32
