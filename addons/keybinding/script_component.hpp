#define COMPONENT keybinding
#include "\x\cba\addons\main\script_mod.hpp"

#ifdef DEBUG_ENABLED_KEYBINDING
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_KEYBINDING
    #define DEBUG_SETTINGS DEBUG_SETTINGS_KEYBINDING
#endif

#include "\x\cba\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineCommonGrids.inc"
#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\a3\ui_f\hpp\defineResincl.inc"

#define IDC_ADDONS_GROUP 4301
#define IDC_BTN_CONFIGURE_ADDONS 4302
#define IDC_BTN_KEYBOARD_FAKE 8000
#define IDC_ADDON_LIST 9000
#define IDC_KEY_LIST 9001

#define POS_X(N) ((N) * GUI_GRID_W + GUI_GRID_CENTER_X)
#define POS_Y(N) ((N) * GUI_GRID_H + GUI_GRID_CENTER_Y)
#define POS_W(N) ((N) * GUI_GRID_W)
#define POS_H(N) ((N) * GUI_GRID_H)

#define DIK_XBOX_A 327680
#define DIK_XBOX_B 327681
#define DIK_XBOX_X 327682
#define DIK_XBOX_Y 327683
#define DIK_XBOX_UP 327684
#define DIK_XBOX_DOWN 327685
#define DIK_XBOX_LEFT 327686
#define DIK_XBOX_RIGHT 327687
#define DIK_XBOX_START 327688
#define DIK_XBOX_BACK 327689
#define DIK_XBOX_BLACK 327690
#define DIK_XBOX_WHITE 327691
#define DIK_XBOX_LEFT_TRIGGER 327692
#define DIK_XBOX_RIGHT_TRIGGER 327693
#define DIK_XBOX_LEFT_THUMB 327694
#define DIK_XBOX_RIGHT_THUMB 327695
#define DIK_XBOX_LEFT_THUMB_X_RIGHT 327696
#define DIK_XBOX_LEFT_THUMB_Y_UP 327697
#define DIK_XBOX_RIGHT_THUMB_X_RIGHT 327698
#define DIK_XBOX_RIGHT_THUMB_Y_UP 327699
#define DIK_XBOX_LEFT_THUMB_X_LEFT 327700
#define DIK_XBOX_LEFT_THUMB_Y_DOWN 327701
#define DIK_XBOX_RIGHT_THUMB_X_LEFT 327702
#define DIK_XBOX_RIGHT_THUMB_Y_DOWN 327703

#define NAMESPACE_NULL objNull
#define HASH_NULL ([] call CBA_fnc_hashCreate)
#define KEYBIND_NULL [0, [false, false, false]]
