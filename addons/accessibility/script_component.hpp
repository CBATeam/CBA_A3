#define COMPONENT accessibility
#include "\x\cba\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define DEBUG_ENABLED_ACCESSIBILITY

#ifdef DEBUG_ENABLED_ACCESSIBILITY
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_ACCESSIBILITY
    #define DEBUG_SETTINGS DEBUG_SETTINGS_ACCESSIBILITY
#endif

#include "\x\cba\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineCommonGrids.inc"

// lower right of screen
#define HINT_CONTAINER_X safezoneX + safezoneW - HINT_CONTAINER_W
#define HINT_CONTAINER_Y safezoneY + safezoneH - HINT_CONTAINER_H
#define HINT_CONTAINER_W 24 * GUI_GRID_CENTER_W
#define HINT_CONTAINER_H 10 * GUI_GRID_CENTER_H
