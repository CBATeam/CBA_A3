#define COMPONENT help
#include "\x\cba\addons\main\script_mod.hpp"

#ifdef DEBUG_ENABLED_HELP
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_HELP
    #define DEBUG_SETTINGS DEBUG_SETTINGS_HELP
#endif

#include "\x\cba\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\a3\ui_f\hpp\defineResincl.inc"

#define POS_X(N) ((N) * GUI_GRID_W + GUI_GRID_X)
#define POS_Y(N) ((N) * GUI_GRID_H + GUI_GRID_Y)
#define POS_W(N) ((N) * GUI_GRID_W)
#define POS_H(N) ((N) * GUI_GRID_H)

#define POS_X_CENTERED(N) ((N) * GUI_GRID_W + GUI_GRID_CENTER_X)
#define POS_X_RIGHT(N) (safezoneW - 1 * (N) * GUI_GRID_W + GUI_GRID_X)

#define POS_X_MAIN_MENU(N) safezoneX
#define POS_Y_MAIN_MENU(N) (safezoneY + safezoneH - 1 * (N) * (pixelH * pixelGrid * 2))
#define POS_W_MAIN_MENU(N) safezoneW
#define POS_H_MAIN_MENU(N) ((N) * (pixelH * pixelGrid * 2))

#define IDC_VERSION_TEXT 222712
#define IDC_VERSION_BUTTON 222713
