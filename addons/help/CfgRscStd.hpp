
class RscButton;
class CBA_Credits_Ver_Btn: RscButton {
    idc = -1; //template
    colorText[] = {1,1,1,0};
    colorDisabled[] = {1,1,1,0};
    colorBackground[] = {1,1,1,0};
    colorBackgroundDisabled[] = {1,1,1,0};
    colorBackgroundActive[] = {1,1,1,0};
    colorShadow[] = {1,1,1,0};
    colorFocused[] = {1,1,1,0};
    soundClick[] = {"",0.1,1};
    x = -1;
    y = -1;
    w = 0;
    h = 0;
    text = "";
};

class RscStructuredText;
class CBA_Credits_Cont: RscStructuredText {
    idc = -1; //template
    colorBackground[] = {0,0,0,0};
    __SX(25);
    __SY(23);
    __SW(30);
    __SH(1);

    class Attributes {
        font = "RobotoCondensed";
        align = "center";
        valign = "bottom";
        color = "#bdcc9c";
        size = 0.8;
    };
};

class RscStandardDisplay;
class RscDisplayMain: RscStandardDisplay {
    class controls {
        class VersionNumber;
        class CBA_Credits_Ver: VersionNumber {
            idc = CBA_CREDITS_VER_IDC;
            y = -1;
        };

        class CBA_Credits_Ver_Btn: CBA_Credits_Ver_Btn {
            idc = CBA_CREDITS_VER_BTN_IDC;
            onMouseButtonClick = QUOTE(_this call COMPILE_FILE(fnc_setVersionLine));
        };

        class CBA_Credits_Cont_C: CBA_Credits_Cont {
            idc = CBA_CREDITS_CONT_IDC;
        };
    };
};

class RscDisplayInterrupt: RscStandardDisplay {
    class controls {
        class CBA_Credits_Cont_C: CBA_Credits_Cont {
            idc = CBA_CREDITS_CONT_IDC;
        };
    };
};

class RscDisplayMPInterrupt: RscStandardDisplay {
    class controls {
        class CBA_Credits_Cont_C: CBA_Credits_Cont {
            idc = CBA_CREDITS_CONT_IDC;
        };
    };
};
