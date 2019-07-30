#define COMPONENT disposable
#include "\x\cba\addons\main\script_mod.hpp"

//#define DEBUG_MODE_FULL
//#define DISABLE_COMPILE_CACHE
//#define DEBUG_ENABLED_DISPOSABLE

#ifdef DEBUG_ENABLED_DISPOSABLE
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_DISPOSABLE
    #define DEBUG_SETTINGS DEBUG_SETTINGS_DISPOSABLE
#endif

#define DEBUG_MODE_NORMAL
#define DEBUG_SYNCHRONOUS
#include "\x\cba\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineResincl.inc"

#define WEAPON_MAGAZINES(unit,weapon) (weaponsItems (unit) select {_x select 0 == (weapon)} param [0, []] select {_x isEqualType []})
