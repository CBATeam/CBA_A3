#define COMPONENT keybinding
#include "\x\cba\addons\main\script_mod.hpp"
#include "\x\cba\addons\main\script_macros.hpp"

#define DEBUG_ENABLED_KEYBINDING

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
