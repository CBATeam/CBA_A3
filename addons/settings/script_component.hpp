#define COMPONENT settings
#include "\x\cba\addons\main\script_mod.hpp"
#include "\x\cba\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\a3\ui_f\hpp\defineCommonGrids.inc"

//#define DEBUG_ENABLED_SETTINGS

#ifdef DEBUG_ENABLED_SETTINGS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_SETTINGS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_SETTINGS
#endif

#define IDC_ADDONS_GROUP 4301
#define IDC_BTN_CONFIGURE_ADDONS 4302
#define IDC_BTN_CLIENT 9000
#define IDC_BTN_SERVER 9001
#define IDC_BTN_MISSION 9002
#define IDC_BTN_IMPORT 9010
#define IDC_BTN_EXPORT 9011
#define IDC_BTN_SAVE 9020
#define IDC_BTN_LOAD 9021
#define IDC_TXT_FORCE 327
#define IDC_OFFSET_SETTING 10000
#define IDC_BTN_SETTINGS 7000

#define IDC_PRESETS_GROUP 8000
#define IDC_PRESETS_TITLE 8001
#define IDC_PRESETS_NAME 8002
#define IDC_PRESETS_EDIT 8003
#define IDC_PRESETS_VALUE 8004
#define IDC_PRESETS_OK 8005
#define IDC_PRESETS_CANCEL 8006
#define IDC_PRESETS_DELETE 8007

#define IS_APEX (productVersion select 2 >= 162)

#define POS_X(N) ((N) * GUI_GRID_W + ([GUI_GRID_X, GUI_GRID_CENTER_X] select IS_APEX))
#define POS_X_LOW(N) ((N) * GUI_GRID_W + GUI_GRID_X)
#define POS_Y(N) ((N) * GUI_GRID_H + ([GUI_GRID_Y, GUI_GRID_CENTER_Y] select IS_APEX))
#define POS_Y_LOW(N) ((N) * GUI_GRID_H + GUI_GRID_Y)
#define POS_W(N) ((N) * GUI_GRID_W)
#define POS_H(N) ((N) * GUI_GRID_H)

#define POS_X_CENTERED(N) ((N) * GUI_GRID_W + GUI_GRID_CENTER_X)
#define POS_Y_CENTERED(N) ((N) * GUI_GRID_H + GUI_GRID_CENTER_Y)

#define COLOR_TEXT_DISABLED [1,1,1,0.3]
#define COLOR_BUTTON_ENABLED [1,1,1,1]
#define COLOR_BUTTON_DISABLED [0,0,0,1]
#define COLOR_TEXT_OVERWRITTEN [1,0.3,0.3,1]

#define SLIDER_TYPES ["CBA_Rsc_Slider_R", "CBA_Rsc_Slider_G", "CBA_Rsc_Slider_B"]
#define SLIDER_COLORS [[1,0,0,1], [0,1,0,1], [0,0,1,1], [1,1,1,1]]

#define MENU_OFFSET_INITIAL 0.3
#define MENU_OFFSET_SPACING 1.4
#define MENU_OFFSET_COLOR 1.0
#define MENU_OFFSET_COLOR_NEG -0.7

#define CAN_SET_CLIENT_SETTINGS (!isMultiplayer || {!isServer}) // in singleplayer or as client in multiplayer
#define CAN_SET_SERVER_SETTINGS (isMultiplayer && {isServer || serverCommandAvailable "#logout"}) // in multiplayer and host (local server) or admin (dedicated)
#define CAN_SET_MISSION_SETTINGS is3den // duh

#ifndef DEBUG_MODE_FULL
    #define CAN_VIEW_CLIENT_SETTINGS (!isMultiplayer || {!isServer}) // hide for local hosted MP client to not confuse
    #define CAN_VIEW_SERVER_SETTINGS isMultiplayer // everyone can peak at those in multiplayer
    #define CAN_VIEW_MISSION_SETTINGS (is3den || missionVersion >= 15) // can view those in 3den or 3den missions
#else
    #define CAN_VIEW_CLIENT_SETTINGS true
    #define CAN_VIEW_SERVER_SETTINGS true
    #define CAN_VIEW_MISSION_SETTINGS true
#endif

// replacement for "LOCATION getVariable [STRING, ANY]"
#define NAMESPACE_GETVAR(namespace,varname,default) ([namespace getVariable varname] param [0, default])

#define GET_VALUE(namespace,setting) ((GVAR(namespace) getVariable setting) param [0])
#define GET_FORCED(namespace,setting) ((NAMESPACE_GETVAR(GVAR(namespace),setting,[]) param [1, false]) || {isMultiplayer && {NAMESPACE_GETVAR(GVAR(defaultSettings),setting,[]) param [7, false]}})

#define GET_TEMP_NAMESPACE(source) ([ARR_3(GVAR(clientSettingsTemp),GVAR(serverSettingsTemp),GVAR(missionSettingsTemp))] param [[ARR_3('client','server','mission')] find toLower source])
#define SET_TEMP_NAMESPACE_VALUE(setting,value,source)   GET_TEMP_NAMESPACE(source) setVariable [ARR_2(setting,[ARR_2(value,(GET_TEMP_NAMESPACE(source) getVariable setting) param [1])])]
#define SET_TEMP_NAMESPACE_FORCED(setting,forced,source) GET_TEMP_NAMESPACE(source) setVariable [ARR_2(setting,[ARR_2((GET_TEMP_NAMESPACE(source) getVariable setting) param [0],forced)])]

#define GET_TEMP_NAMESPACE_VALUE(setting,source)  ((GET_TEMP_NAMESPACE(source) getVariable setting) param [0])
#define GET_TEMP_NAMESPACE_FORCED(setting,source) ((GET_TEMP_NAMESPACE(source) getVariable setting) param [1])

#define NULL_HASH ([] call CBA_fnc_hashCreate)
