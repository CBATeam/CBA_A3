#define true    1
#define false    0

// Import needed base classes.
class RscText;
class RscVignette;
class RscControlsGroup {
    class VScrollbar;
    class HScrollbar;
};
class RscControlsGroupNoScrollbars;
class RscFrame;
class RscTitle;
class RscButtonMenu;
class RscButtonMenuCancel;
class RscButtonMenuOK;
class RscCombo;
class RscListBox;
class RscListNBox;
class RscListBoxKeys;

///////////////////////////////////////////////////////////////////////////////
// ADD CONFIGURE ADDONS BUTTON TO DEFAULT CONTROLS DIALOG
// !!! This overloads the BI onLoad value !!!
///////////////////////////////////////////////////////////////////////////////

class RscDisplayConfigure {
    class controls {
        class CA_ButtonCancel: RscButtonMenuCancel {
            onButtonClick = "_this call cba_keybinding_fnc_onButtonClick_cancel";
        };

        class CBA_ButtonConfigureAddons : RscButtonMenuOK {
            idc = 4302;
            text = CSTRING(configureAddons);
            onButtonClick = "_this call cba_keybinding_fnc_onButtonClick_configure";
            x = "20.15 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
            y = "23 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
            w = "12.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };

        class CBA_FakeButtonKeyboard: RscButtonMenu {
            idc = 4303;
            text = "$STR_A3_RscDisplayConfigure_ButtonKeyboard";
            x = "1 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
            y = "2.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
            w = "8 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        };

        class CBA_AddonsGroup : RscControlsGroup {
            class VScrollbar : VScrollbar {
                width = 0;
            };
            class HScrollbar : HScrollbar {
                height = 0;
            };
            idc = 4301;
            enableDisplay = 0;
            x = "1 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2)";
            y = "3.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
            w = "38 * (((safezoneW / safezoneH) min 1.2) / 40)";
            h = "19.6 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

            class controls {
                class CBA_AddonsEmptyText : RscText {
                    idc = -1;
                    type = 0;
                    x = "0 * (((safezoneW / safezoneH) min 1.2) / 40)";
                    y = "0 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    w = "1 * (((safezoneW / safezoneH) min 1.2) / 40)";
                    h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    text = "";
                };
                class CBA_AddonsEmptyBackground : RscText {
                    idc = -1;
                    type = 0;
                    text = "";
                    colorBackground[] = {0,0,0,0.4};
                    x = "0.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
                    y = "3.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    w = "35 * (((safezoneW / safezoneH) min 1.2) / 40)";
                    h = "13.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                };
                class CBA_AddonsCA_ControlsPageText : RscText {
                    sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
                    style = 1;
                    idc = 2002;
                    text = "Addon:";
                    x = "0.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
                    y = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    w = "4 * (((safezoneW / safezoneH) min 1.2) / 40)";
                    h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                };
                class CBA_AddonsCA_ControlsPage : RscCombo {
                    idc = 208;
                    linespacing = 1;
                    text = "";

                    onLBSelChanged = "_this call cba_keybinding_fnc_onComboChanged";

                    wholeHeight = "12 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    x = "4.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
                    y = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    w = "21 * (((safezoneW / safezoneH) min 1.2) / 40)";
                    h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                };
                class CBA_AddonsCA_ValueKeys : RscListNBox {
                    idc = 202;
                    columns[] = {0,0.54285};
                    drawSideArrows = false;
                    idcLeft = -1;
                    idcRight = -1;

                    onLBDblClick = "_this call cba_keybinding_fnc_onLBDblClick";

                    rowHeight = 0.042;
                    x = "0.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
                    y = "3.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    w = "35 * (((safezoneW / safezoneH) min 1.2) / 40)";
                    h = "13.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                };
                class CBA_AddonsTextAction : RscText {
                    idc = 2003;
                    text = "$STR_A3_RscDisplayConfigure_TextAction";
                    x = "0.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
                    y = "2.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    w = "19 * (((safezoneW / safezoneH) min 1.2) / 40)";
                    h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    colorBackground[] = {0,0,0,1};
                };
                class CBA_AddonsTextAssignedKeys : RscText {
                    idc = 2004;
                    text = "$STR_A3_RscDisplayConfigure_TextAssignedKeys";
                    x = "19.48 * (((safezoneW / safezoneH) min 1.2) / 40)";
                    y = "2.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    w = "16 * (((safezoneW / safezoneH) min 1.2) / 40)";
                    h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    colorBackground[] = {0,0,0,1};
                };
                class CBA_B_Delete : RscButtonMenu {
                    idc = 204;
                    text = "$STR_DISP_DELETE";
                    x = "6.85 * (((safezoneW / safezoneH) min 1.2) / 40)";
                    y = "17.45 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    w = "6.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
                    h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

                    onButtonClick = "_this call cba_keybinding_fnc_onButtonClick_delete";
                };
                class CBA_ButtonDefault : RscButtonMenu {
                    idc = 205;
                    text = "$STR_DISP_DEFAULT";
                    x = "0.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
                    y = "17.45 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    w = "6.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
                    h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

                    onButtonClick = "_this call cba_keybinding_fnc_onButtonClick_default";
                };
                class CBA_TextHelp: RscText {
                    idc = 206;
                    text = ""; // Set in script to avoid automatic uppercasing
                    x = "13.5 * (((safezoneW / safezoneH) min 1.2) / 40)";
                    y = "17.45 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                    w = "21 * (((safezoneW / safezoneH) min 1.2) / 40)";
                    h = "1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
                };
            };
        };
    };
};
