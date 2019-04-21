#define COMPONENT optics
#include "\x\cba\addons\main\script_mod.hpp"

//#define DEBUG_MODE_FULL
//#define DISABLE_COMPILE_CACHE
//#define DEBUG_ENABLED_OPTICS

#ifdef DEBUG_ENABLED_OPTICS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_OPTICS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_OPTICS
#endif

#define DEBUG_MODE_NORMAL
#define DEBUG_SYNCHRONOUS
#include "\x\cba\addons\main\script_macros.hpp"

#define PARSE(value) (call compile format ["%1", value])
#define AMBIENT_BRIGHTNESS (sunOrMoon * sunOrMoon * (1 - overcast * 0.25) + moonIntensity / 5 * (1 - overcast) min 1) // idea by Falke
#define WEAPON_MAGAZINES(unit,weapon) (weaponsItems (unit) select {_x select 0 == (weapon)} param [0, []] select {_x isEqualType []})

// addWeapon, but without leeching magazines
#define ADD_GUN(unit,gun) (call {\
    private _loadout = getUnitLoadout (unit);\
    _loadout select 0 set [0, gun];\
    (unit) setUnitLoadout _loadout;\
})

#define ADD_LAUNCHER(unit,launcher) (call {\
    private _loadout = getUnitLoadout (unit);\
    _loadout select 1 set [0, launcher];\
    (unit) setUnitLoadout _loadout;\
})

#define ADD_PISTOL(unit,pistol) (call {\
    private _loadout = getUnitLoadout (unit);\
    _loadout select 2 set [0, pistol];\
    (unit) setUnitLoadout _loadout;\
})

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

#define RETICLE_SAFEZONE_SIZE 0.84
#define RETICLE_SAFEZONE_WIDTH POS_W(RETICLE_SAFEZONE_SIZE)
#define RETICLE_SAFEZONE_HEIGHT POS_H(RETICLE_SAFEZONE_SIZE)
#define RETICLE_SAFEZONE_LEFT POS_X(RETICLE_SAFEZONE_SIZE)
#define RETICLE_SAFEZONE_TOP POS_Y(RETICLE_SAFEZONE_SIZE)

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
