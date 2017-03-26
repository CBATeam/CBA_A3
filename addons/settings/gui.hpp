
class RscButtonMenu;
class RscControlsGroupNoScrollbars;
class RscText;

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

        class CBA_ButtonServer: RscButtonMenu {
            idc = IDC_BTN_SERVER;
            text = CSTRING(ButtonServer);
            tooltip = CSTRING(ButtonServer_tooltip);
            x = POS_X(1);
            y = POS_Y(2.1);
            w = POS_W(8);
            h = POS_H(1);
        };

        class CBA_ButtonMission: CBA_ButtonServer {
            idc = IDC_BTN_MISSION;
            text = CSTRING(ButtonMission);
            tooltip = CSTRING(ButtonMission_tooltip);
            x = POS_X(9);
        };

        class CBA_ButtonClient: CBA_ButtonServer {
            idc = IDC_BTN_CLIENT;
            text = CSTRING(ButtonClient);
            tooltip = CSTRING(ButtonClient_tooltip);
            x = POS_X(17);
        };

        class CBA_AddonsGroup: RscControlsGroupNoScrollbars {
            idc = IDC_ADDONS_GROUP;
            enableDisplay = 0;
            x = POS_X(1);
            y = POS_Y(3.1);
            w = POS_W(38);
            h = POS_H(17.3);

            class controls {
                class Background: RscText {
                    idc = -1;
                    colorBackground[] = {0,0,0,0.4};
                    x = POS_W(0.5);
                    y = POS_H(3.5);
                    w = POS_W(37);
                    h = POS_H(13.8);
                };
                class AddonText: RscText {
                    idc = -1;
                    style = ST_RIGHT;
                    text = "Addon:";
                    x = POS_W(0.5);
                    y = POS_H(1);
                    w = POS_W(4);
                    h = POS_H(1);
                    sizeEx = POS_H(1);
                };
                class OverwriteClientText: RscText {
                    // Set tooltip per script to avoid it being all upper case.
                    // Disable multiline text to make in unselectable.
                    onLoad = QUOTE((_this select 0) ctrlSetText localize QUOTE(LSTRING(overwrite_clients)); (_this select 0) ctrlEnable false;);
                    idc = IDC_TXT_OVERWRITE_CLIENT;
                    style = ST_MULTI + ST_CENTER;
                    x = POS_W(30.5);
                    y = POS_H(2);
                    w = POS_W(3);
                    h = POS_H(2*3/4);
                    sizeEx = POS_H(3/4);
                };
                class OverwriteMissionText: OverwriteClientText {
                    onLoad = QUOTE((_this select 0) ctrlSetText localize QUOTE(LSTRING(overwrite_mission)); (_this select 0) ctrlEnable false;);
                    idc = IDC_TXT_OVERWRITE_MISSION;
                    x = POS_W(33.5);
                };
            };
        };
    };
};

class GVAR(ButtonConfigure_base): RscButtonMenu {
    onButtonClick = QUOTE(ctrlParent (_this select 0) call COMPILE_FILE(openSettingsMenu));
    idc = IDC_BTN_CONFIGURE;
    text = CSTRING(configureAddons);
    x = POS_X_LOW(11.1);
    y = POS_Y_LOW(23);
    w = POS_W(10);
    h = POS_H(1);
};

class RscDisplayMainMap;
class RscDisplayGetReady: RscDisplayMainMap {
    class controls {
        class GVAR(ButtonConfigure): GVAR(ButtonConfigure_base) {};
    };
};

class RscDisplayServerGetReady: RscDisplayGetReady {
    class controls {
        class GVAR(ButtonConfigure): GVAR(ButtonConfigure_base) {};
    };
};

class RscDisplayClientGetReady: RscDisplayGetReady {
    class controls {
        class GVAR(ButtonConfigure): GVAR(ButtonConfigure_base) {};
    };
};

class RscControlsGroupNoHScrollbars;
class GVAR(OptionsGroup): RscControlsGroupNoHScrollbars {
    x = POS_W(0);
    y = POS_H(3.5);
    w = POS_W(37.5);
    h = POS_H(13.8);
    lineHeight = POS_H(1);
};

// Has to be created dynamically for every options group, because they would
// interfere with the controls groups otherwise. Scripted controls are always
// placed below config controls.
class RscCombo;
class GVAR(AddonsList): RscCombo {
    linespacing = 1;
    text = "";
    wholeHeight = POS_H(12);
    x = POS_W(4.5);
    y = POS_H(1);
    w = POS_W(21);
    h = POS_H(1);
};

class RscButton;
class RscPicture;

class RscCheckBox;
class GVAR(CheckboxSound): RscCheckBox {
    soundEnter[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundEnter",0.090000004,1};
    soundPush[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundPush",0.090000004,1};
    soundClick[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundClick",0.090000004,1};
    soundEscape[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundEscape",0.090000004,1};
};

class GVAR(Row_Base): RscControlsGroupNoScrollbars {
    GVAR(script) = "";
    x = POS_W(1);
    y = POS_H(0);
    w = POS_W(37);
    h = POS_H(1) + TABLE_LINE_SPACING;

    class controls {
        class Background: RscText {
            idc = IDC_SETTING_BACKGROUND;
            colorBackground[] = {0,0,0,0.4};
            x = POS_W(0);
            y = POS_H(0) + TABLE_LINE_SPACING/2;
            w = POS_W(36);
            h = POS_H(1);
        };
        class Name: RscText {
            idc = IDC_SETTING_NAME;
            style = ST_RIGHT;
            x = POS_W(0);
            y = POS_H(0) + TABLE_LINE_SPACING/2;
            w = POS_W(15.5);
            h = POS_H(1);
        };
        class Default: RscButton {
            idc = IDC_SETTING_DEFAULT;
            style = ST_PICTURE;
            text = ICON_DEFAULT;
            tooltip = CSTRING(default_tooltip);
            x = POS_W(26.5);
            y = POS_H(0) + TABLE_LINE_SPACING/2;
            w = POS_W(1);
            h = POS_H(1);
        };
        class Locked: RscPicture {
            idc = IDC_SETTING_LOCKED;
            text = QPATHTOF(locked_ca.paa);
            colorText[] = {1,0,0,1};
            x = POS_W(28);
            y = POS_H(0) + TABLE_LINE_SPACING/2;
            w = POS_W(1);
            h = POS_H(1);
        };
        class OverwriteClients: GVAR(CheckboxSound) {
            idc = IDC_SETTING_OVERWRITE_CLIENT;
            x = POS_W(30.5);
            y = POS_H(0) + TABLE_LINE_SPACING/2;
            w = POS_W(1);
            h = POS_H(1);
        };
        class OverwriteMission: OverwriteClients {
            idc = IDC_SETTING_OVERWRITE_MISSION;
            x = POS_W(33.5);
        };
    };
};

class GVAR(Row_Checkbox): GVAR(Row_Base) {
    GVAR(script) = QFUNC(gui_settingCheckbox);

    class controls: controls {
        class Name: Name {};
        class Checkbox: GVAR(CheckboxSound) {
            idc = IDC_SETTING_CHECKBOX;
            x = POS_W(16);
            y = POS_H(0) + TABLE_LINE_SPACING/2;
            w = POS_W(1);
            h = POS_H(1);
        };
        class Default: Default {};
        class Locked: Locked {};
        class OverwriteClients: OverwriteClients {};
        class OverwriteMission: OverwriteMission {};
    };
};

class RscEdit;

class GVAR(Row_Editbox): GVAR(Row_Base) {
    GVAR(script) = QFUNC(gui_settingEditbox);

    class controls: controls {
        class Name: Name {};
        class Editbox: RscEdit {
            idc = IDC_SETTING_EDITBOX;
            x = POS_W(16);
            y = POS_H(0) + TABLE_LINE_SPACING/2;
            w = POS_W(10);
            h = POS_H(1);
        };
        class Default: Default {};
        class Locked: Locked {};
        class OverwriteClients: OverwriteClients {};
        class OverwriteMission: OverwriteMission {};
    };
};

class GVAR(Row_List): GVAR(Row_Base) {
    GVAR(script) = QFUNC(gui_settingList);

    class controls: controls {
        class Name: Name {};
        class List: RscCombo {
            idc = IDC_SETTING_LIST;
            x = POS_W(16);
            y = POS_H(0) + TABLE_LINE_SPACING/2;
            w = POS_W(10);
            h = POS_H(1);
        };
        class Default: Default {};
        class Locked: Locked {};
        class OverwriteClients: OverwriteClients {};
        class OverwriteMission: OverwriteMission {};
    };
};

class RscXSliderH;

class GVAR(Row_Slider): GVAR(Row_Base) {
    GVAR(script) = QFUNC(gui_settingSlider);

    class controls: controls {
        class Name: Name {};
        class Slider: RscXSliderH {
            idc = IDC_SETTING_SLIDER;
            x = POS_W(16);
            y = POS_H(0) + TABLE_LINE_SPACING/2;
            w = POS_W(8);
            h = POS_H(1);
        };
        class Edit: RscEdit {
            idc = IDC_SETTING_SLIDER_EDIT;
            x = POS_W(24);
            y = POS_H(0) + TABLE_LINE_SPACING/2;
            w = POS_W(2);
            h = POS_H(1);
        };
        class Default: Default {};
        class Locked: Locked {};
        class OverwriteClients: OverwriteClients {};
        class OverwriteMission: OverwriteMission {};
    };
};

class GVAR(Row_Color): GVAR(Row_Base) {
    GVAR(script) = QFUNC(gui_settingColor);
    h = POS_H(3) + TABLE_LINE_SPACING;

    class controls: controls {
        class Name: Name {
            y = POS_H(0.5) + TABLE_LINE_SPACING/2;
        };
        class Preview: RscText {
            idc = IDC_SETTING_COLOR_PREVIEW;
            x = POS_W(9.5);
            y = POS_H(1.5) + TABLE_LINE_SPACING/2;
            w = POS_W(6);
            h = POS_H(1);
        };
        class Red: RscXSliderH {
            idc = IDC_SETTING_COLOR_RED;
            color[] = {1,0,0,0.6};
            colorActive[] = {1,0,0,1};
            colorDisable[] = {1,0,0,0.4};
            x = POS_W(16);
            y = POS_H(0) + TABLE_LINE_SPACING/2;
            w = POS_W(8);
            h = POS_H(1);
        };
        class Red_Edit: RscEdit {
            idc = IDC_SETTING_COLOR_RED_EDIT;
            x = POS_W(24);
            y = POS_H(0) + TABLE_LINE_SPACING/2;
            w = POS_W(2);
            h = POS_H(1);
        };
        class Green: Red {
            idc = IDC_SETTING_COLOR_GREEN;
            color[] = {0,1,0,0.6};
            colorActive[] = {0,1,0,1};
            colorDisable[] = {0,1,0,0.4};
            y = POS_H(1) + TABLE_LINE_SPACING/2;
        };
        class Green_Edit: Red_Edit {
            idc = IDC_SETTING_COLOR_GREEN_EDIT;
            y = POS_H(1) + TABLE_LINE_SPACING/2;
        };
        class Blue: Red {
            idc = IDC_SETTING_COLOR_BLUE;
            color[] = {0,0,1,0.6};
            colorActive[] = {0,0,1,1};
            colorDisable[] = {0,0,1,0.4};
            y = POS_H(2) + TABLE_LINE_SPACING/2;
        };
        class Blue_Edit: Red_Edit {
            idc = IDC_SETTING_COLOR_BLUE_EDIT;
            y = POS_H(2) + TABLE_LINE_SPACING/2;
        };
        class Default: Default {
            y = POS_H(1) + TABLE_LINE_SPACING/2;
        };
        class Locked: Locked {
            y = POS_H(1) + TABLE_LINE_SPACING/2;
        };
        class OverwriteClients: OverwriteClients {
            y = POS_H(1) + TABLE_LINE_SPACING/2;
        };
        class OverwriteMission: OverwriteMission {
            y = POS_H(1) + TABLE_LINE_SPACING/2;
        };
    };
};

class GVAR(Row_ColorAlpha): GVAR(Row_Color) {
    h = POS_H(4) + TABLE_LINE_SPACING;

    class controls: controls {
        class Name: Name {
            y = POS_H(1) + TABLE_LINE_SPACING/2;
        };
        class Preview: Preview {
            y = POS_H(2) + TABLE_LINE_SPACING/2;
        };
        class Red: Red {};
        class Red_Edit: Red_Edit {};
        class Green: Green {};
        class Green_Edit: Green_Edit {};
        class Blue: Blue {};
        class Blue_Edit: Blue_Edit {};
        class Alpha: RscXSliderH {
            idc = IDC_SETTING_COLOR_ALPHA;
            x = POS_W(16);
            y = POS_H(3) + TABLE_LINE_SPACING/2;
            w = POS_W(8);
            h = POS_H(1);
        };
        class Alpha_Edit: RscEdit {
            idc = IDC_SETTING_COLOR_ALPHA_EDIT;
            x = POS_W(24);
            y = POS_H(3) + TABLE_LINE_SPACING/2;
            w = POS_W(2);
            h = POS_H(1);
        };
        class Default: Default {
            y = POS_H(1.5) + TABLE_LINE_SPACING/2;
        };
        class Locked: Locked {
            y = POS_H(1.5) + TABLE_LINE_SPACING/2;
        };
        class OverwriteClients: OverwriteClients {
            y = POS_H(1.5) + TABLE_LINE_SPACING/2;
        };
        class OverwriteMission: OverwriteMission {
            y = POS_H(1.5) + TABLE_LINE_SPACING/2;
        };
    };
};

class RscControlsGroup;
class RscTitle;
class RscListBox;

class GVAR(presets) {
    idd = -1;
    movingEnable = 1;
    enableSimulation = 0;

    class controls {
        class Presets: RscControlsGroup {
            idc = IDC_PRESETS_GROUP;
            x = POS_X(10);
            y = POS_Y(0.9);
            w = POS_W(20);
            h = POS_H(22.2);

            class controls {
                class Title: RscTitle {
                    colorBackground[] = {
                        "(profileNamespace getVariable ['GUI_BCG_RGB_R',0.77])",
                        "(profileNamespace getVariable ['GUI_BCG_RGB_G',0.51])",
                        "(profileNamespace getVariable ['GUI_BCG_RGB_B',0.08])",
                        "(profileNamespace getVariable ['GUI_BCG_RGB_A',0.8])"
                    };
                    idc = IDC_PRESETS_TITLE;
                    text = "";
                    x = POS_W(0);
                    y = POS_H(0);
                    w = POS_W(20);
                    h = POS_H(1);
                };
                class Background: RscText {
                    idc = -1;
                    colorBackground[] = {0,0,0,0.8};
                    x = POS_W(0);
                    y = POS_H(1.1);
                    w = POS_W(20);
                    h = POS_H(20);
                };
                class TextName: RscText {
                    idc = IDC_PRESETS_NAME;
                    style = ST_RIGHT;
                    text = "$STR_DISP_INTEL_NAME";
                    x = POS_W(0.5);
                    y = POS_H(19.6);
                    w = POS_W(5.5);
                    h = POS_H(1);
                    sizeEx = POS_H(0.8);
                };
                class EditName: RscEdit {
                    idc = IDC_PRESETS_EDIT;
                    x = POS_W(6);
                    y = POS_H(19.6);
                    w = POS_W(13.5);
                    h = POS_H(1);
                    sizeEx = POS_H(0.8);
                };
                class ValueName: RscListBox {
                    idc = IDC_PRESETS_VALUE;
                    colorBackground[] = {1,1,1,0.2};
                    x = POS_W(0.5);
                    y = POS_H(1.6);
                    w = POS_W(19);
                    h = POS_H(17.5);
                    sizeEx = POS_H(0.8);
                };
                class ButtonOK: RscButtonMenu {
                    idc = IDC_PRESETS_OK;
                    text = "$STR_DISP_OK";
                    x = POS_W(15);
                    y = POS_H(21.2);
                    w = POS_W(5);
                    h = POS_H(1);
                };
                class ButtonCancel: RscButtonMenu {
                    idc = IDC_PRESETS_CANCEL;
                    text = "$STR_DISP_CANCEL";
                    x = POS_W(0);
                    y = POS_H(21.2);
                    w = POS_W(5);
                    h = POS_H(1);
                };
                class ButtonDelete: RscButtonMenu {
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
