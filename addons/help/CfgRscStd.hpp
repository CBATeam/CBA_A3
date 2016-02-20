#include "script_dialog_defines.hpp"

class RscStandardDisplay;
class RscStructuredText;
class RscButton;
class RscControlsGroupNoScrollbars;

class CBA_CREDITS_CONT: RscStructuredText {
    idc = -1; //template
    colorBackground[] = { 0, 0, 0, 0 };
    __SX(25);
    __SY(23);
    __SW(30);
    __SH(1);
    class Attributes {
        font = "PuristaLight";
        align = "center";
        valign = "bottom";
        color = "#bdcc9c";
        size = 0.8;
    };
};

class CBA_CREDITS_VER_BTN: RscButton {
    idc = -1; //template
    colorText[] = {1, 1, 1, 0};
    colorDisabled[] = {1, 1, 1, 0};
    colorBackground[] = {1, 1, 1, 0};
    colorBackgroundDisabled[] = {1, 1, 1, 0};
    colorBackgroundActive[] = {1, 1, 1, 0};
    colorShadow[] = {1, 1, 1, 0};
    colorFocused[] = {1, 1, 1, 0};
    soundClick[] = {"", 0.1, 1};
    x = -1;
    y = -1;
    w = 0;
    h = 0;
    text = "";
};

class RscDisplayMain: RscStandardDisplay {
    class controls {
        class VersionNumber;

        class CBA_CREDITS_VER: VersionNumber {
            idc = CBA_CREDITS_VER_IDC;
            y = -1;
        };
        class CBA_CREDITS_VER_BTN: CBA_CREDITS_VER_BTN {
            idc = CBA_CREDITS_VER_BTN_IDC;
            onMouseButtonClick = "_this call compile preprocessFileLineNumbers '\x\cba\addons\help\ver_line.sqf';";
            onMouseEnter = QUOTE(GVAR(VerPause) = true);
            onMouseExit = QUOTE(GVAR(VerPause) = nil);
        };
        class CBA_CREDITS_CONT_C : CBA_CREDITS_CONT {
            idc = CBA_CREDITS_CONT_IDC;
        };
    };
};

class RscDisplayInterrupt: RscStandardDisplay {
    class controls {
        class CBA_CREDITS_CONT_C: CBA_CREDITS_CONT {
            idc = CBA_CREDITS_CONT_IDC;
        };
    };
};

class RscDisplayMPInterrupt: RscStandardDisplay {
    class controls {
        class CBA_CREDITS_CONT_C: CBA_CREDITS_CONT {
            idc = CBA_CREDITS_CONT_IDC;
        };
    };
};
