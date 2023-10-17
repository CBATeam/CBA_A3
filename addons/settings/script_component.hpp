#define COMPONENT settings
#include "\x\cba\addons\main\script_mod.hpp"

#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\a3\ui_f\hpp\defineResincl.inc"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define DEBUG_ENABLED_SETTINGS

#ifdef DEBUG_ENABLED_SETTINGS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_SETTINGS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_SETTINGS
#endif

#define DEBUG_SYNCHRONOUS
#include "\x\cba\addons\main\script_macros.hpp"

#define IDC_ADDONS_GROUP 4301
#define IDC_BTN_CONFIGURE_ADDONS 4302
#define IDC_BTN_CLIENT 9001
#define IDC_BTN_MISSION 9002
#define IDC_BTN_SERVER 9003
#define IDC_BTN_IMPORT 9010
#define IDC_BTN_EXPORT 9011
#define IDC_BTN_SAVE 9020
#define IDC_BTN_LOAD 9021
#define IDC_BTN_CONFIGURE 9030
#define IDC_TXT_OVERWRITE_CLIENT 9040
#define IDC_TXT_OVERWRITE_MISSION 9041
#define IDC_TXT_VOLATILE_WARNING 9042

#define IDC_SETTING_CONTROLS_GROUP 5000
#define IDC_SETTING_BACKGROUND 5001
#define IDC_SETTING_NAME 5010
#define IDC_SETTING_DEFAULT 5020
#define IDC_SETTING_LOCKED 5030
#define IDC_SETTING_OVERWRITE_CLIENT 5040
#define IDC_SETTING_OVERWRITE_MISSION 5041
#define IDC_SETTING_CHECKBOX 5100
#define IDC_SETTING_EDITBOX 5101
#define IDC_SETTING_LIST 5110
#define IDC_SETTING_SLIDER 5120
#define IDC_SETTING_SLIDER_EDIT 5121
#define IDC_SETTING_COLOR_PREVIEW 5130
#define IDC_SETTING_COLOR_RED 5131
#define IDC_SETTING_COLOR_RED_EDIT 5132
#define IDC_SETTING_COLOR_GREEN 5133
#define IDC_SETTING_COLOR_GREEN_EDIT 5134
#define IDC_SETTING_COLOR_BLUE 5135
#define IDC_SETTING_COLOR_BLUE_EDIT 5136
#define IDC_SETTING_COLOR_ALPHA 5137
#define IDC_SETTING_COLOR_ALPHA_EDIT 5138
#define IDC_SETTING_TIME_SLIDER 5140
#define IDC_SETTING_TIME_HOURS 5141
#define IDC_SETTING_TIME_MINUTES 5142
#define IDC_SETTING_TIME_SECONDS 5143

#define IDCS_SETTING_COLOR [IDC_SETTING_COLOR_RED, IDC_SETTING_COLOR_GREEN, IDC_SETTING_COLOR_BLUE, IDC_SETTING_COLOR_ALPHA]
#define IDCS_SETTING_COLOR_EDIT [IDC_SETTING_COLOR_RED_EDIT, IDC_SETTING_COLOR_GREEN_EDIT, IDC_SETTING_COLOR_BLUE_EDIT, IDC_SETTING_COLOR_ALPHA_EDIT]

#define IDC_PRESETS_GROUP 8000
#define IDC_PRESETS_TITLE 8001
#define IDC_PRESETS_NAME 8002
#define IDC_PRESETS_EDIT 8003
#define IDC_PRESETS_VALUE 8004
#define IDC_PRESETS_OK 8005
#define IDC_PRESETS_CANCEL 8006
#define IDC_PRESETS_DELETE 8007

#define IDC_EXPORT_GROUP 8100
#define IDC_EXPORT_TITLE 8101
#define IDC_EXPORT_VALUE_GROUP 8103
#define IDC_EXPORT_VALUE 8104
#define IDC_EXPORT_OK 8106
#define IDC_EXPORT_CANCEL 8107
#define IDC_EXPORT_TOGGLE_DEFAULT_TEXT 8200
#define IDC_EXPORT_TOGGLE_DEFAULT 8201

#define IDC_MAIN_ADDONOPTIONS 12701

#define POS_X(N) ((N) * GUI_GRID_W + GUI_GRID_CENTER_X)
#define POS_Y(N) ((N) * GUI_GRID_H + GUI_GRID_CENTER_Y)
#define POS_W(N) ((N) * GUI_GRID_W)
#define POS_H(N) ((N) * GUI_GRID_H)

#define POS_X_LOW(N) ((N) * GUI_GRID_W + GUI_GRID_X)
#define POS_Y_LOW(N) ((N) * GUI_GRID_H + GUI_GRID_Y)

#define TABLE_LINE_SPACING POS_H(0.4)

#define COLOR_TEXT_ENABLED [1, 1, 1, 1]
#define COLOR_TEXT_ENABLED_WAS_EDITED [0.95, 0.95, 0.1, 1]
#define COLOR_TEXT_DISABLED [1, 1, 1, 0.4]
#define COLOR_BUTTON_ENABLED [1, 1, 1, 1]
#define COLOR_BUTTON_DISABLED [0, 0, 0, 1]

#define ICON_DEFAULT "\a3\3den\Data\Displays\Display3DEN\ToolBar\undo_ca.paa"
#define ICON_APPLIES QPATHTOF(applies_ca.paa)
#define ICON_OVERWRITTEN QPATHTOF(overwritten_ca.paa)
#define ICON_NEED_RESTART QPATHTOF(need_restart_ca.paa)

#define COLOR_APPLIES [0, 0.95, 0, 1]
#define COLOR_OVERWRITTEN [0.95, 0, 0, 1]
#define COLOR_OVERWRITTEN_EQUAL [0.95, 0.55, 0, 1]
#define COLOR_NEED_RESTART [0.95, 0.95, 0, 1]

#define CAN_SET_SERVER_SETTINGS ((isServer || FUNC(whitelisted)) && {!isNull GVAR(server)}) // in single player, as host (local server) or as logged in (not voted) admin connected to a dedicated server
#define CAN_SET_CLIENT_SETTINGS !isServer // in multiplayer as dedicated client
#define CAN_SET_MISSION_SETTINGS is3den // in editor

#define CAN_VIEW_SERVER_SETTINGS !isNull GVAR(server) // everyone can peak at those in multiplayer
#define CAN_VIEW_CLIENT_SETTINGS !isServer // in multiplayer as dedicated client
#define CAN_VIEW_MISSION_SETTINGS (is3den || {missionVersion >= 15}) // can view those in 3den or 3den missions

#define HASH_NULL ([] call CBA_fnc_hashCreate)
#define NAMESPACE_NULL objNull

#define GET_TEMP_NAMESPACE(source) ((with uiNamespace do {[GVAR(clientTemp), GVAR(missionTemp), GVAR(serverTemp)]}) param [["client", "mission", "server"] find toLower source, NAMESPACE_NULL])
#define GET_TEMP_NAMESPACE_VALUE(setting,source)    (GET_TEMP_NAMESPACE(source) getVariable [setting, [nil, nil]] select 0)
#define GET_TEMP_NAMESPACE_PRIORITY(setting,source) (GET_TEMP_NAMESPACE(source) getVariable [setting, [nil, nil]] select 1)

#define SET_TEMP_NAMESPACE_AWAITING_RESTART(setting) if (toLower setting in GVAR(needRestart) && {!is3den}) then {GVAR(awaitingRestartTemp) pushBackUnique toLower setting}
#define SET_TEMP_NAMESPACE_VALUE(setting,value,source)       GET_TEMP_NAMESPACE(source) setVariable [setting, [value, GET_TEMP_NAMESPACE_PRIORITY(setting,source)]]; SET_TEMP_NAMESPACE_AWAITING_RESTART(setting)
#define SET_TEMP_NAMESPACE_PRIORITY(setting,priority,source) GET_TEMP_NAMESPACE(source) setVariable [setting, [GET_TEMP_NAMESPACE_VALUE(setting,source), priority]]; SET_TEMP_NAMESPACE_AWAITING_RESTART(setting)

#define GET_SERVER_NAMESPACE (with missionNamespace do {if (isDedicated && {GVAR(volatile)}) then {uiNamespace} else {profileNamespace}})

#define TEMP_PRIORITY(setting) (call {private _arr = [\
    (uiNamespace getVariable QGVAR(clientTemp))  getVariable [setting, [nil, [setting,  "client"] call FUNC(priority)]] select 1,\
    (uiNamespace getVariable QGVAR(missionTemp)) getVariable [setting, [nil, [setting, "mission"] call FUNC(priority)]] select 1,\
    (uiNamespace getVariable QGVAR(serverTemp))  getVariable [setting, [nil, [setting,  "server"] call FUNC(priority)]] select 1\
]; ["client", "mission", "server"] select (_arr find selectMax _arr)})

#define TEMP_VALUE_SOURCE(setting,source) ([\
    (uiNamespace getVariable QGVAR(clientTemp))  getVariable [setting, [[setting,  "client"] call FUNC(get), nil]] select 0,\
    (uiNamespace getVariable QGVAR(missionTemp)) getVariable [setting, [[setting, "mission"] call FUNC(get), nil]] select 0,\
    (uiNamespace getVariable QGVAR(serverTemp))  getVariable [setting, [[setting,  "server"] call FUNC(get), nil]] select 0\
] select (["client", "mission", "server"] find (source)))

#define TEMP_VALUE(setting) TEMP_VALUE_SOURCE(setting,TEMP_PRIORITY(setting))

#define ASCII_NEWLINE 10
#define ASCII_CARRIAGE_RETURN 13
#define ASCII_TAB 9
#define ASCII_SPACE 32
#define NEWLINE toString [ASCII_NEWLINE]
#define WHITESPACE toString [ASCII_NEWLINE, ASCII_CARRIAGE_RETURN, ASCII_TAB, ASCII_SPACE]

#define USERCONFIG_SETTINGS_FILE "userconfig\cba_settings.sqf"
#define USERCONFIG_SETTINGS_FILE_ADDON "\cba_settings_userconfig\cba_settings.sqf"
#define MISSION_SETTINGS_FILE "cba_settings.sqf"

// lbSetCurSel triggers the LBSelChanged event. Sometimes we don't want that.
// This is a mutex to exit the eventhandler code.
#define LOCK GVAR(lock) = true
#define UNLOCK GVAR(lock) = nil
#define EXIT_LOCKED if (!isNil QGVAR(lock)) exitWith {}

// Keep quote marks for strings, but also print "<any>" if undefined.
// str and format ["%1", ] on their own can only do either.
#define TO_STRING(var) (call {private _str = var; if (_str isEqualType "") then {_str = str _str}; format ["%1", _str]})

#define IS_GLOBAL_SETTING(setting) (GVAR(default) getVariable [setting, []] param [7, 0] == 1)
#define IS_LOCAL_SETTING(setting)  (GVAR(default) getVariable [setting, []] param [7, 0] == 2)

#define SANITIZE_PRIORITY(setting,priority,source) (call {\
    private _priority = priority;\
    if (_priority isEqualType false) then {\
        _priority = parseNumber _priority;\
    };\
    if (IS_GLOBAL_SETTING(setting) && {source != "mission"}) exitWith {_priority max 1};\
    if (IS_LOCAL_SETTING(setting)) exitWith {_priority min 0};\
    _priority\
})

#define STR_SOURCE ([LSTRING(ButtonMission),LSTRING(ButtonClient)] param [["mission","client"] find (uiNamespace getVariable QGVAR(source)), LSTRING(ButtonServer)])
