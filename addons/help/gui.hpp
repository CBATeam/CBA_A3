class RscText;
class RscButton;
class RscStructuredText {
    class Attributes;
};

class GVAR(credits_base): RscStructuredText {
    onLoad = QUOTE(_this call (uiNamespace getVariable 'FUNC(setCreditsLine)'));
    size = POS_H(0.8);
    x = POS_X_CENTERED(7);
    y = POS_Y(23.1);
    w = POS_W(26);
    h = POS_H(0.8);
    shadow = 0;

    class Attributes: Attributes {
        font = "RobotoCondensedLight";
        align = "center";
        valign = "middle";
        color = "#bdcc9c";
    };
};

class RscStandardDisplay;
class RscDisplayMain: RscStandardDisplay {
    class controls {
        class GVAR(CreditsVersion): RscText {
            onLoad = QUOTE(_this call (uiNamespace getVariable 'FUNC(setVersionLine)'));
            idc = IDC_VERSION_TEXT;
            font = "RobotoCondensedLight";
            shadow = 0;
            style = ST_RIGHT;
            sizeEx = POS_H(0.8);
            x = POS_X_RIGHT(12);
            y = POS_Y(24.1);
            w = POS_W(10);
            h = POS_H(0.8);
        };

        class GVAR(CreditsVersionButton): RscButton {
            onMouseButtonClick = QUOTE(_this call (uiNamespace getVariable 'FUNC(setVersionLine)'));
            idc = IDC_VERSION_BUTTON;
            colorText[] = {1,1,1,0};
            colorDisabled[] = {1,1,1,0};
            colorBackground[] = {0,0,0,0};
            colorBackgroundDisabled[] = {0,0,0,0};
            colorBackgroundActive[] = {0,0,0,0};
            colorFocused[] = {0,0,0,0};
            soundClick[] = {"",1,1};

            x = POS_X_RIGHT(12);
            y = POS_Y(24.1);
            w = POS_W(10);
            h = POS_H(0.8);
        };

        class GVAR(credits): GVAR(credits_base) {
            size = POS_H_MAIN_MENU(1);
            x = POS_X_MAIN_MENU(0);
            y = POS_Y_MAIN_MENU(2);
            w = POS_W_MAIN_MENU(0);
            h = POS_H_MAIN_MENU(1);
        };
    };
};

class RscDisplayInterrupt: RscStandardDisplay {
    class controls {
        class GVAR(credits): GVAR(credits_base) {};
    };
};

class RscDisplayMPInterrupt: RscStandardDisplay {
    class controls {
        class GVAR(credits): GVAR(credits_base) {};
    };
};
