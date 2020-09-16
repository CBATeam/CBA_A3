#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = CSTRING(component);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_common", "cba_hashes"};
        author = "$STR_CBA_Author";
        authors[] = {"Spooner", "Sickboy", "Xeno", "commy2"};
        url = "$STR_CBA_URL";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"

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
            hasOptic = 1; // Set to 1 to do optic check with inbuild optic (no attachment)
            soundEmpty = ""; // sound played on the last round
            soundLocationEmpty = ""; // Where the sound for the last round is played.
        };
    };
};
#endif

//["testcomponent1", "test1", {systemChat str 11}] call CBA_fnc_addKeyHandlerFromConfig;
//["testcomponent1", "test2", {systemChat str 12}] call CBA_fnc_addKeyHandlerFromConfig;
//["testcomponent2", "test1", {systemChat str 21}] call CBA_fnc_addKeyHandlerFromConfig;
//["testcomponent2", "test2", {systemChat str 22}] call CBA_fnc_addKeyHandlerFromConfig;

/*class CfgSettings {
    class CBA {
        class events {
            class testcomponent1 {
                test1 = 15;

                class test2 {
                    key = 15;
                    shift = 1;
                };
            };

            class testcomponent2 {
                test1 = 19;

                class test2 {
                    key = 19;
                    ctrl = 1;
                };
            };
        };
    };
};*/
