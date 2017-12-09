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

#define DEBUG_MODE_FULL
#ifdef DEBUG_MODE_FULL
class CfgWeapons {
    class arifle_MX_Base_F;
    class arifle_MX_F: arifle_MX_Base_F {
        class EventHandlers {
            fired = "_this call CBA_fnc_weaponEvents";
        };

        class CBA_weaponEvents {
            onEmpty = 0;
            handAction = "gestureNo";
            sound = "Alarm"; // from CfgSounds
            soundLocation = "LeftHandMiddle1"; // alternative: "RightHandMiddle1"
            delay = 0.5; // in seconds
        };
    };
};
#endif
