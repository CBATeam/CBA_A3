class RscControlsGroup;
class RscControlsGroupNoScrollbars;
class RscText;
class RscButton;
class RscButtonMenu;
class RscCombo;
class RscStructuredText;

class GVAR(key): RscControlsGroupNoScrollbars {
    idc = -1;
    enableDisplay = 0;
    x = QUOTE(POS_W(0));
    y = QUOTE(POS_H(0));
    w = QUOTE(POS_W(37));
    h = QUOTE(POS_H(1));

    class controls {
        class EditButton: RscButton {
            idc = IDC_KEY_EDIT;
            onButtonClick = QUOTE(call (uiNamespace getVariable 'FUNC(gui_editKey)'));
            onMouseEnter = "(_this select 0) ctrlSetTextColor [0,0,0,1]";
            onMouseExit = "(_this select 0) ctrlSetTextColor [1,1,1,1]";
            style = ST_LEFT;
            shadow = 0;
            colorBackground[] = {0,0,0,0};
            colorBackgroundActive[] = {1,1,1,1};
            colorFocused[] = {0.5,0.5,0.5,0.5};
            tooltipColorBox[] = {1,1,1,1};
            tooltipColorShade[] = {0,0,0,0.7};
            tooltipColorText[] = {1,1,1,1};
            x = QUOTE(POS_W(0));
            y = QUOTE(POS_H(0));
            w = QUOTE(POS_W(17));
            h = QUOTE(POS_H(1));
        };

        class AssignedKey: RscStructuredText {
            idc = IDC_KEY_ASSIGNED;
            shadow = 0;
            tooltipColorBox[] = {1,1,1,1};
            tooltipColorShade[] = {0,0,0,0.7};
            tooltipColorText[] = {1,1,1,1};
            x = QUOTE(POS_W(17));
            y = QUOTE(POS_H(0));
            w = QUOTE(POS_W(20));
            h = QUOTE(POS_H(1));
        };
    };
};

class GVAR(subCat): RscControlsGroupNoScrollbars {
    x = QUOTE(POS_W(1));
    y = QUOTE(POS_H(0));
    w = QUOTE(POS_W(37));
    h = QUOTE(POS_H(1));

    class controls {
        class Background: RscText {
            colorBackground[] = {0.15,0.15,0.15,0.4};
            x = QUOTE(POS_W(0));
            y = QUOTE(POS_H(0));
            w = QUOTE(POS_W(36));
            h = QUOTE(POS_H(1));
        };

        class Name: RscText {
            idc = IDC_SUBCATEGORY_NAME;
            style = ST_LEFT;
            SizeEx = QUOTE(POS_H(1));
            x = QUOTE(POS_W(0));
            y = QUOTE(POS_H(0));
            w = QUOTE(POS_W(15.5));
            h = QUOTE(POS_H(1));
        };

        class Bar: RscText {
            colorBackground[] = {1,1,1,1};
            style = ST_LEFT;
            x = QUOTE(POS_W(0));
            y = QUOTE(POS_H(1) - 2 * pixelH);
            w = QUOTE(POS_W(36));
            h = QUOTE(pixelH);
        };
    };
};

class RscDisplayConfigure {
    class controls {
        class CBA_ButtonConfigureAddons: RscButtonMenu {
            onButtonClick = QUOTE(call (uiNamespace getVariable 'FUNC(gui_configure)'));
            idc = IDC_BTN_CONFIGURE_ADDONS;
            text = CSTRING(configureAddons);
            x = QUOTE(POS_X(20.15));
            y = QUOTE(POS_Y(23));
            w = QUOTE(POS_W(12.5));
            h = QUOTE(POS_H(1));
        };

        class CBA_ButtonKeyboardFake: RscButtonMenu {
            idc = IDC_BTN_KEYBOARD_FAKE;
            text = "$STR_A3_RscDisplayConfigure_ButtonKeyboard";
            x = QUOTE(POS_X(1));
            y = QUOTE(POS_Y(2.1));
            w = QUOTE(POS_W(8));
            h = QUOTE(POS_H(1));
        };

        class CBA_AddonsGroup: RscControlsGroupNoScrollbars {
            idc = IDC_ADDONS_GROUP;
            enableDisplay = 0;
            x = QUOTE(POS_X(1));
            y = QUOTE(POS_Y(3.1));
            w = QUOTE(POS_W(38));
            h = QUOTE(POS_H(19.6));

            class controls {
                class Background: RscText {
                    colorBackground[] = {0, 0, 0, 0.4};
                    x = QUOTE(POS_W(0.5));
                    y = QUOTE(POS_H(3.5));
                    w = QUOTE(POS_W(37));
                    h = QUOTE(POS_H(15.8));
                };
                class AddonText: RscText {
                    style = ST_RIGHT;
                    text = ECSTRING(main,AddonText);
                    x = QUOTE(POS_W(0.5));
                    y = QUOTE(POS_H(1));
                    w = QUOTE(POS_W(4));
                    h = QUOTE(POS_H(1));
                    sizeEx = QUOTE(POS_H(1));
                };
                class AddonsList: RscCombo {
                    idc = IDC_ADDON_LIST;
                    x = QUOTE(POS_W(4.5));
                    y = QUOTE(POS_H(1));
                    w = QUOTE(POS_W(21));
                    h = QUOTE(POS_H(1));
                    wholeHeight = QUOTE(POS_H(12));
                };
                class KeyList: RscControlsGroup {
                    idc = IDC_KEY_LIST;
                    x = QUOTE(POS_W(0.5));
                    y = QUOTE(POS_H(3.5));
                    w = QUOTE(POS_W(37));
                    h = QUOTE(POS_H(15.8));
                };
                class TextAction: RscText {
                    onLoad = "(_this select 0) ctrlSetText toUpper ctrlText (_this select 0)";
                    text = "$STR_A3_RscDisplayConfigure_TextAction";
                    x = QUOTE(POS_W(0.5));
                    y = QUOTE(POS_H(2.5));
                    w = QUOTE(POS_W(17));
                    h = QUOTE(POS_H(1));
                    colorBackground[] = {0, 0, 0, 1};
                };
                class TextAssignedKeys: RscText {
                    onLoad = "(_this select 0) ctrlSetText toUpper ctrlText (_this select 0)";
                    text = "$STR_A3_RscDisplayConfigure_TextAssignedKeys";
                    x = QUOTE(POS_W(17.5));
                    y = QUOTE(POS_H(2.5));
                    w = QUOTE(POS_W(20));
                    h = QUOTE(POS_H(1));
                    colorBackground[] = {0, 0, 0, 1};
                };
            };
        };
    };
};
