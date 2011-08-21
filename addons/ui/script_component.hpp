#define COMPONENT ui
#include "\x\cba\addons\main\script_mod.hpp"

//#define DEBUG_ENABLED_UI

#ifdef DEBUG_ENABLED_UI
	#define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_UI
	#define DEBUG_SETTINGS DEBUG_SETTINGS_UI
#endif

#include "\x\cba\addons\main\script_macros.hpp"

// #include "\x\cba\addons\ui\flexiMenu\data\common.hpp"

// this is a duplicate #define which should match the one in script_component.hpp
#define _flexiMenu_useSlowCleanDrawMode

//#define _flexiMenu_IDD 406

#define _flexiMenu_maxButtons 30
#define _flexiMenu_maxListButtons 30

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

#define _menuRscPrefix "CBA_flexiMenu_rsc"

#define _flexiMenu_path QUOTE(PATHTOF(flexiMenu))
//#define _eval_action(_param) __EVAL(format ["[%2] execVM '%1\action.sqf'", _flexiMenu_path, ##_param])

#define _SMW 0.15*safeZoneW // common sub-menu width

#define _LBH 0.033*safeZoneH // list button height


// additional "_SUB" macros to handle sub folders
#define PATHTO_SUB(var1,var2,var3,var4) MAINPREFIX\##var1\SUBPREFIX\##var2\##var3\##var4.sqf
#define COMPILE_FILE_SUB(var1,var2,var3,var4) COMPILE_FILE2(PATHTO_SUB(var1,var2,var3,var4))
#define PREP_SYS_SUB(var1,var2,var3,var4) ##var1##_##var2##_fnc_##var4 = COMPILE_FILE_SUB(var1,var2,var3,DOUBLES(fnc,var4))
#define PREP_SUB(var1,var2) PREP_SYS_SUB(PREFIX,COMPONENT_F,var1,var2)

// array select with bounds check (for optional parameters)
#define IfCountDefault(var1,array2,index3,default4) ##var1 = if (count ##array2 > ##index3) then { ##array2 select ##index3 } else { ##default4 };

