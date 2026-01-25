#define COMPONENT optics
#include "\x\cba\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define DEBUG_ENABLED_OPTICS

#ifdef DEBUG_ENABLED_OPTICS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_OPTICS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_OPTICS
#endif

#define DEBUG_SYNCHRONOUS
#include "\x\cba\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineDIKCodes.inc"

#define PARSE(value) (call compile format ["%1", value])
#define AMBIENT_BRIGHTNESS (sunOrMoon * sunOrMoon * (1 - overcast * 0.25) + moonIntensity / 5 * (1 - overcast) min 1) // idea by Falke
#define WEAPON_MAGAZINES(unit,weapon) (weaponsItems (unit) select {_x select 0 == (weapon)} param [0, []] select {_x isEqualType []})

#define SOUND_RETICLE_SWITCH ["A3\Sounds_F\arsenal\weapons\UGL\Firemode_ugl",0.31622776,1,5]
#define THIRD_SCREEN_WIDTH ((safeZoneX - safeZoneXAbs) * ((getResolution select 4)/(16/3)))

// control ids
#define IDC_RETICLE 4000
#define IDC_BODY 4001
#define IDC_BODY_NIGHT 4002
#define IDC_RETICLE_SAFEZONE 4010
#define IDC_BLACK_SCOPE 4020
#define IDC_BLACK_LEFT 4021
#define IDC_BLACK_RIGHT 4022
#define IDC_RED_DOT 4030
#define IDC_MAGNIFICATION 4040
#define IDC_ACTIVE_DISPLAY 8888
#define IDC_ENABLE_ZOOM 9999

// control positions
#define POS_W(size) ((size) / (getResolution select 5))
#define POS_H(size) (POS_W(size) * 4/3)
#define POS_X(size) (0.5 - 0.5 * POS_W(size))
#define POS_Y(size) (0.5 - 0.5 * POS_H(size))

#define RETICLE_SAFEZONE_DEFAULT_SIZE 0.84
#define RETICLE_SAFEZONE_DEFAULT_WIDTH POS_W(RETICLE_SAFEZONE_DEFAULT_SIZE)
#define RETICLE_SAFEZONE_DEFAULT_HEIGHT POS_H(RETICLE_SAFEZONE_DEFAULT_SIZE)
#define RETICLE_SAFEZONE_DEFAULT_LEFT POS_X(RETICLE_SAFEZONE_DEFAULT_SIZE)
#define RETICLE_SAFEZONE_DEFAULT_TOP POS_Y(RETICLE_SAFEZONE_DEFAULT_SIZE)

// scope animation config
#define SCOPE_RECOIL_COEF 1
#define SCOPE_RECOIL_COEF_RESTED 0.4
#define SCOPE_RECOIL_COEF_DEPLOYED 0.1

#define SCOPE_RECOIL_MIN 0.03
#define SCOPE_RECOIL_MAX 0.032

#define SCOPE_SHIFT_X_MIN 0.04
#define SCOPE_SHIFT_X_MAX 0.05
#define SCOPE_SHIFT_Y_MIN -0.02
#define SCOPE_SHIFT_Y_MAX -0.03

#define RETICLE_SHIFT_X_MIN 0.006
#define RETICLE_SHIFT_X_MAX 0.011
#define RETICLE_SHIFT_Y_MIN -0.009
#define RETICLE_SHIFT_Y_MAX -0.014

#define RECENTER_TIME 0.09
