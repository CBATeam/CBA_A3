#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = CSTRING(component);
        url = "$STR_CBA_URL";
        units[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"CBA_common"};
        version = VERSION;
        authors[] = {"Spooner", "Sickboy", "Xeno", "commy2"};
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgFunctions.hpp"

class RscDisplayChat {
    onKeyDown = QUOTE(\
        if ((_this select 1) in [ARR_2(DIK_RETURN,DIK_NUMPADENTER)]) then {\
            [ARR_2('GVAR(chatMessageSent)',[ARR_2(ctrlText ((_this select 0) displayctrl 101),_this select 0)])] call CBA_fnc_localEvent;\
        };\
        false\
    );
};

//#define DEBUG_MODE_FULL
#ifdef DEBUG_MODE_FULL
class CfgWeapons {
    class arifle_MX_Base_F;
    class arifle_MX_F: arifle_MX_Base_F {
        class EventHandlers {
            fired = "_this call CBA_fnc_weaponEvents"; // this weapon eventhandler is required!
        };
        class CBA_weaponEvents {
            handAction = "gestureNo"; // hand animation, from CfgGesturesMale\States
            sound = "Alarm"; // from CfgSounds
            soundLocation = "LeftHandMiddle1"; // Where the sound is played. Selection on the soldier, not the weapon! Alternative: RightHandMiddle1
            delay = 0.5; // delay for sound and hand animation, in seconds
            onEmpty = 0; // 1: play sound and action defined above on the last round, 0: don't, default 1; the sound below is played anyway
            soundEmpty = ""; // sound played on the last round
            soundLocationEmpty = ""; // Where the sound for the last round is played.
        };
    };
};
#endif
