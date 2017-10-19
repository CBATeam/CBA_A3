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
