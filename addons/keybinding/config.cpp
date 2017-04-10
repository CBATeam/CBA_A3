#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = CSTRING(component);
        url = "$STR_CBA_URL";
        units[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"CBA_common", "A3_UI_F"};
        version = VERSION;
        authors[] = {"Taosenai"};
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgFunctions.hpp"

#include "gui\gui.hpp"

//class RscButtonMenu;

class RscStandardDisplay;
class RscDisplayInterrupt: RscStandardDisplay {
    class controls {
        class ButtonVideo: RscButtonMenu {
            y = POS_Y(18.6 - 5 * 1.1);
        };

        class ButtonAudio: RscButtonMenu {
            y = POS_Y(18.6 - 4 * 1.1);
        };

        class ButtonControls: RscButtonMenu {
            y = POS_Y(18.6 - 3 * 1.1);
        };

        class GVAR(AddonControls): RscButtonMenu {
            idc = IDC_ADDON_CONTROLS;
            text = "Addon Controls";
            tooltip = "";
            x = POS_X(2);
            y = POS_Y(18.6 - 2 * 1.1);
            w = POS_W(14);
            h = POS_H(1);
        };

        class ButtonGame: RscButtonMenu {
            y = POS_Y(18.6 - 1 * 1.1);
        };

        class GVAR(AddonOptions): RscButtonMenu {
            idc = IDC_ADDON_OPTIONS;
            text = "Addon Options";
            tooltip = "";
            x = POS_X(2);
            y = POS_Y(18.6);
            w = POS_W(14);
            h = POS_H(1);
        };
    };
};
