
class RscControlsGroup {
    class VScrollbar;
    class HScrollbar;
};

class RscTitle;
class RscText;
class CBA_Rsc_SettingText: RscText {
    style = 0x01;
};

class RscEdit;
class RscCombo;
class RscListBox;
class RscButtonMenu;

// can't set the colorDisable with SQF, so we have to create our own base classes when we want to use these with ctrlCreate
class RscXSliderH;
class CBA_Rsc_Slider_R: RscXSliderH {
    color[] = {1,0,0,0.6};
    colorActive[] = {1,0,0,1};
    colorDisable[] = {1,0,0,0.4};
};
class CBA_Rsc_Slider_G: RscXSliderH {
    color[] = {0,1,0,0.6};
    colorActive[] = {0,1,0,1};
    colorDisable[] = {0,1,0,0.4};
};
class CBA_Rsc_Slider_B: RscXSliderH {
    color[] = {0,0,1,0.6};
    colorActive[] = {0,0,1,1};
    colorDisable[] = {0,0,1,0.4};
};

class GVAR(OptionsGroup): RscControlsGroup {
    class HScrollbar: HScrollbar {
        height = 0;
    };
    x = POS_W(0.5);
    y = POS_H(3.5);
    w = POS_W(35);
    h = POS_H(13.8);
    lineHeight = POS_H(1);

    class controls {}; // auto generated
};

// have to create to dynamically for every options group, because they would interfere with the controls groups otherwise
// has to be done, because scripted controls are always placed below regular (config) ones.
class GVAR(AddonsList): RscCombo {
    linespacing = 1;
    text = "";
    wholeHeight = POS_H(12);
    x = POS_W(4.5);
    y = POS_H(1);
    w = POS_W(21);
    h = POS_H(1);
};

class RscDisplayGameOptions {
    class controls {
        class CBA_ButtonConfigureAddons: RscButtonMenu {
            idc = IDC_BTN_CONFIGURE_ADDONS;
            text = CSTRING(configureAddons);
            x = POS_X(20.15);
            y = POS_Y(23);
            w = POS_W(12.5);
            h = POS_H(1);
        };

        class CBA_ButtonClient: RscButtonMenu {
            idc = IDC_BTN_CLIENT;
            text = CSTRING(ButtonClient);
            tooltip = CSTRING(ButtonClient_tooltip);
            x = POS_X(1);
            y = POS_Y(2.1);
            w = POS_W(8);
            h = POS_H(1);
        };

        class CBA_ButtonMission: CBA_ButtonClient {
            idc = IDC_BTN_MISSION;
            text = CSTRING(ButtonMission);
            tooltip = CSTRING(ButtonMission_tooltip);
            x = POS_X(9);
        };

        class CBA_ButtonServer: CBA_ButtonClient {
            onLoad = QUOTE(\
                if (!isMultiplayer) then {\
                    params ['_control'];\
                    _control ctrlSetText localize QUOTE(LSTRING(ButtonLocal));\
                };\
            );
            idc = IDC_BTN_SERVER;
            text = CSTRING(ButtonServer);
            tooltip = CSTRING(ButtonServer_tooltip);
            x = POS_X(17);
        };

        class CBA_AddonsGroup: RscControlsGroup {
            class VScrollbar: VScrollbar {
                width = 0;
            };
            class HScrollbar: HScrollbar {
                height = 0;
            };
            idc = IDC_ADDONS_GROUP;
            enableDisplay = 0;
            x = POS_X(1);
            y = POS_Y(3.1);
            w = POS_W(38);
            h = POS_H(17.3);

            class controls {
                class CBA_AddonsEmptyBackground: RscText {
                    idc = -1;
                    type = 0x00;
                    text = "";
                    colorBackground[] = {0,0,0,0.4};
                    x = POS_W(0.5);
                    y = POS_H(3.5);
                    w = POS_W(35);
                    h = POS_H(13.8);
                };
                class CBA_AddonsCA_ControlsPageText: RscText {
                    style = 0x01;
                    idc = 2002;
                    text = "Addon:";
                    x = POS_W(0.5);
                    y = POS_H(1);
                    w = POS_W(4);
                    h = POS_H(1);
                    sizeEx = POS_H(1);
                };
                class CBA_ForceSettingText: RscText {
                    style = 0x01;
                    idc = IDC_TXT_FORCE;
                    text = "";
                    tooltip = CSTRING(force_tooltip);
                    x = POS_W(25);
                    y = POS_H(2.5);
                    w = POS_W(10);
                    h = POS_H(1);
                };
            };
        };
    };
};

class CBA_ButtonConfigureSettings_base: RscButtonMenu {
    onButtonClick = QUOTE(ctrlParent (_this select 0) call COMPILE_FILE(openSettingsMenu));
    idc = IDC_BTN_SETTINGS;
    text = CSTRING(configureAddons);
    x = POS_X_LOW(11.1);
    y = POS_Y_LOW(23);
    w = POS_W(10);
    h = POS_H(1);
};

class RscDisplayMainMap;
class RscDisplayGetReady: RscDisplayMainMap {
    class controls {
        class CBA_ButtonConfigureSettings: CBA_ButtonConfigureSettings_base {};
    };
};

class RscDisplayServerGetReady: RscDisplayGetReady {
    class controls {
        class CBA_ButtonConfigureSettings: CBA_ButtonConfigureSettings_base {};
    };
};

class RscDisplayClientGetReady: RscDisplayGetReady {
    class controls {
        class CBA_ButtonConfigureSettings: CBA_ButtonConfigureSettings_base {};
    };
};

class GVAR(presets) {
    idd = -1;
    movingEnable = 1;
    enableSimulation = 0;

    class controls {
        class CBA_Presets: RscControlsGroup {
            idc = IDC_PRESETS_GROUP;
            x = POS_X(10);
            y = POS_Y(0.9);
            w = POS_W(20);
            h = POS_H(22.2);

            class controls {
                class CBA_Title: RscTitle {
                    style = 0;
                    colorBackground[] = {
                        "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])",
                        "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])",
                        "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",
                        "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"
                    };
                    idc = IDC_PRESETS_TITLE;
                    text = "";
                    x = POS_W(0);
                    y = POS_H(0);
                    w = POS_W(20);
                    h = POS_H(1);
                };
                class CBA_Background: RscText {
                    idc = -1;
                    colorBackground[] = {0,0,0,0.8};
                    x = POS_W(0);
                    y = POS_H(1.1);
                    w = POS_W(20);
                    h = POS_H(20);
                };
                class CBA_TextName: RscText {
                    style = 1;
                    idc = IDC_PRESETS_NAME;
                    text = "$STR_DISP_INTEL_NAME";
                    x = POS_W(0.5);
                    y = POS_H(19.6);
                    w = POS_W(5.5);
                    h = POS_H(1);
                    sizeEx = POS_H(0.8);
                };
                class CBA_EditName: RscEdit {
                    idc = IDC_PRESETS_EDIT;
                    x = POS_W(6);
                    y = POS_H(19.6);
                    w = POS_W(13.5);
                    h = POS_H(1);
                    sizeEx = POS_H(0.8);
                };
                class CBA_ValueName: RscListBox {
                    idc = IDC_PRESETS_VALUE;
                    colorBackground[] = {1,1,1,0.2};
                    x = POS_W(0.5);
                    y = POS_H(1.6);
                    w = POS_W(19);
                    h = POS_H(17.5);
                    sizeEx = POS_H(0.8);
                };
                class CBA_ButtonOK: RscButtonMenu {
                    idc = IDC_PRESETS_OK;
                    text = "$STR_DISP_OK";
                    x = POS_W(15);
                    y = POS_H(21.2);
                    w = POS_W(5);
                    h = POS_H(1);
                };
                class CBA_ButtonCancel: RscButtonMenu {
                    idc = IDC_PRESETS_CANCEL;
                    text = "$STR_DISP_CANCEL";
                    x = POS_W(0);
                    y = POS_H(21.2);
                    w = POS_W(5);
                    h = POS_H(1);
                };
                class CBA_ButtonDelete: RscButtonMenu {
                    idc = IDC_PRESETS_DELETE;
                    text = "$STR_DISP_DELETE";
                    x = POS_W(9.9);
                    y = POS_H(21.2);
                    w = POS_W(5);
                    h = POS_H(1);
                };
            };
        };
    };
};
