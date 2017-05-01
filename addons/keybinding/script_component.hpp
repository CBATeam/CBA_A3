#define COMPONENT keybinding
#include "\x\cba\addons\main\script_mod.hpp"
#include "\x\cba\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineDIKCodes.inc"

//#define DEBUG_ENABLED_KEYBINDING

#ifdef DEBUG_ENABLED_KEYBINDING
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_KEYBINDING
    #define DEBUG_SETTINGS DEBUG_SETTINGS_KEYBINDING
#endif

#define PATHTO_SUB(var1,var2,var3,var4) MAINPREFIX\##var1\SUBPREFIX\##var2\##var3\##var4.sqf
#define COMPILE_FILE_SUB(var1,var2,var3,var4) COMPILE_FILE2(PATHTO_SUB(var1,var2,var3,var4))
#define PREP_SYS_SUB(var1,var2,var3,var4) ##var1##_##var2##_fnc_##var4 = COMPILE_FILE_SUB(var1,var2,var3,DOUBLES(fnc,var4))
#define PREP_SUB(var1,var2) PREP_SYS_SUB(PREFIX,COMPONENT_F,var1,var2)

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
