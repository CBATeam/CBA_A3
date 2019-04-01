#define COMPONENT 2doptics
#include "\x\cba\addons\main\script_mod.hpp"

//#define DEBUG_MODE_FULL
//#define DISABLE_COMPILE_CACHE
//#define DEBUG_ENABLED_2DOPTICS

#ifdef DEBUG_ENABLED_2DOPTICS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_2DOPTICS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_2DOPTICS
#endif

#define DEBUG_SYNCHRONOUS
#include "\x\cba\addons\main\script_macros.hpp"

#define PARSE(value) (call compile format ["%1", value])

// control ids
#define IDC_RETICLE 10000
#define IDC_BODY 10001
#define IDC_BODY_NIGHT 10002
#define IDC_RETICLE_SAFEZONE 10010
#define IDC_BLACK_SCOPE 10020
#define IDC_BLACK_LEFT 10021
#define IDC_BLACK_RIGHT 10022
#define IDC_RED_DOT 10030
#define IDC_MAGNIFICATION 10040
#define IDC_ENABLE_ZOOM 99999

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

// CfgWeapons classes
#define PIP(optic) class DOUBLES(optic,pip): optic {\
    GVAR(nonPIPOptic) = #optic;\
    scope = 1;\
\
    class ItemInfo: ItemInfo {\
        modelOptics = QPATHTOF(cba_optic_big_pip.p3d);\
    };\
}

/*
 //BWA3_G36CarryHandleScriptedOptic_base
#define CARRY_HANDLE(optic,weapon) class DOUBLES(optic,weapon): optic {\
    scope = 1;\
\
    class CBA_ScriptedOptic: GVAR(CarryHandleScriptedOptic_base) {};\
    weaponInfoType = "RscWeaponZeroing";\
\
    class ItemInfo: ItemInfo {\
        modelOptics = QPATHTOF(cba_optic_big_90.p3d);\
\
        class OpticsModes: OpticsModes {\
            class Scope: BWA3_G36CarryHandleScope_base {};\
            class Kolimator: Kolimator {};\
        };\
    };\
};\
\
PIP(classname##_G36A2)

#define HAS_CARRY_HANDLE(weapon) (getNumber (configFile >> "CfgWeapons" >> (weapon) >> "BWA3_useCarryHandleOptics") isEqualTo 1)
