// THIS IS A COPY OF DATA INSIDE x\cba\addons\ui\script_component.hpp   for legacy purposes
// Somehow using this common.hpp is problematic for some.

// this is a duplicate #define which should match the one in script_component.hpp
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
