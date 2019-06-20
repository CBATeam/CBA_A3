#define COMPONENT ui
#include "\x\cba\addons\main\script_mod.hpp"

//#define DEBUG_MODE_FULL
//#define DISABLE_COMPILE_CACHE
//#define DEBUG_ENABLED_UI

#ifdef DEBUG_ENABLED_UI
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_UI
    #define DEBUG_SETTINGS DEBUG_SETTINGS_UI
#endif

#define DEBUG_SYNCHRONOUS
#include "\x\cba\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\a3\ui_f\hpp\defineCommonColors.inc"
#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\a3\ui_f\hpp\defineResincl.inc"

#define IDC_PROGRESSBAR_TITLE 10
#define IDC_PROGRESSBAR_BAR 11
#define IDC_PROGRESSBAR_SCRIPT 12

#define IDC_ADDON_CONTROLS 127303
#define IDC_ADDON_OPTIONS 127307

#define POS_X(N) ((N) * GUI_GRID_W + GUI_GRID_X)
#define POS_Y(N) ((N) * GUI_GRID_H + GUI_GRID_Y)
#define POS_W(N) ((N) * GUI_GRID_W)
#define POS_H(N) ((N) * GUI_GRID_H)

// notify
#define NOTIFY_DEFAULT_X (safezoneX + safezoneW - 13 * GUI_GRID_W)
#define NOTIFY_DEFAULT_Y (safezoneY + 6 * GUI_GRID_H)
#define NOTIFY_MIN_WIDTH (12 * GUI_GRID_W)
#define NOTIFY_MIN_HEIGHT (3 * GUI_GRID_H)

// Warning: this block below is a duplicate copy of the contents from common.hpp
// #include "\x\cba\addons\ui\flexiMenu\data\common.hpp"

#define _flexiMenu_useSlowCleanDrawMode

//#define _flexiMenu_IDD 406

#define _flexiMenu_maxButtons 100
#define _flexiMenu_maxListButtons 100

#define _flexiMenu_IDC_menuDesc 230
#define _flexiMenu_IDC_listMenuDesc 231

// Base IDC value of first button.
#define _flexiMenu_baseIDC_button 240
// Successive buttons are numbered in sequence from base IDC value.
// _flexiMenu_maxButtons represents theoretical maximum IDC value. Each dialog determines this upper limit itself.
// The reserved range of IDC's is from: _flexiMenu_baseIDC_button to (_flexiMenu_baseIDC_button+_flexiMenu_maxButtons-1).

// Base IDC value of first list button.
#define _flexiMenu_baseIDC_listButton 340

#define _flexiMenu_typeMenuSources_ID_type 0
#define _flexiMenu_typeMenuSources_ID_DIKCodes 1
#define _flexiMenu_typeMenuSources_ID_priority 2
#define _flexiMenu_typeMenuSources_ID_menuSource 3

#define _flexiMenu_menuProperty_ID_menuName 0
#define _flexiMenu_menuProperty_ID_menuDesc 1
#define _flexiMenu_menuProperty_ID_menuResource 2
#define _flexiMenu_menuProperty_ID_iconFolder 3
#define _flexiMenu_menuProperty_ID_multiReselect 4

#define _flexiMenu_menuDef_ID_caption 0
#define _flexiMenu_menuDef_ID_action 1
#define _flexiMenu_menuDef_ID_icon 2
#define _flexiMenu_menuDef_ID_tooltip 3
#define _flexiMenu_menuDef_ID_subMenuSource 4
#define _flexiMenu_menuDef_ID_shortcut 5
#define _flexiMenu_menuDef_ID_enabled 6
#define _flexiMenu_menuDef_ID_visible 7
#define _flexiMenu_menuDef_ID_totalIDs 8

#define __menuRscPrefix "CBA_flexiMenu_rsc"
#define __SMW_default 0.15 * safeZoneW // common sub-menu width, used in script
#define __defaultHotkeyColor "#f07EB27E"

// array select with bounds check (for optional parameters)
#define IfCountDefault(var1,array2,index3,default4) ##var1 = if (count ##array2 > ##index3) then {##array2 select ##index3} else {##default4};
