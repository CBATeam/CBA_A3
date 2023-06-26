class RscButtonMenu;
class RscControlsGroupNoScrollbars;
class RscText;

class RscDisplayGameOptions {
    // pause game in SP while this menu is shown
    // usually paused by other displays present for the vanilla options menu
    enableSimulation = 0;

    class controls {
        class CBA_ButtonConfigureAddons: RscButtonMenu {
            idc = IDC_BTN_CONFIGURE_ADDONS;
            text = CSTRING(configureAddons);
            x = QUOTE(POS_X(20.15));
            y = QUOTE(POS_Y(23));
            w = QUOTE(POS_W(12.5));
            h = QUOTE(POS_H(1));
        };

        class CBA_ButtonServer: RscButtonMenu {
            idc = IDC_BTN_SERVER;
            text = CSTRING(ButtonServer);
            tooltip = CSTRING(ButtonServer_tooltip);
            x = QUOTE(POS_X(1));
            y = QUOTE(POS_Y(2.1));
            w = QUOTE(POS_W(8));
            h = QUOTE(POS_H(1));
        };

        class CBA_ButtonMission: CBA_ButtonServer {
            idc = IDC_BTN_MISSION;
            text = CSTRING(ButtonMission);
            tooltip = CSTRING(ButtonMission_tooltip);
            x = QUOTE(POS_X(9));
        };

        class CBA_ButtonClient: CBA_ButtonServer {
            idc = IDC_BTN_CLIENT;
            text = CSTRING(ButtonClient);
            tooltip = CSTRING(ButtonClient_tooltip);
            x = QUOTE(POS_X(17));
        };

        class CBA_AddonsGroup: RscControlsGroupNoScrollbars {
            idc = IDC_ADDONS_GROUP;
            enableDisplay = 0;
            x = QUOTE(POS_X(1));
            y = QUOTE(POS_Y(3.1));
            w = QUOTE(POS_W(38));
            h = QUOTE(POS_H(17.3));

            class controls {
                class Background: RscText {
                    idc = -1;
                    colorBackground[] = {0,0,0,0.4};
                    x = QUOTE(POS_W(0.5));
                    y = QUOTE(POS_H(3.5));
                    w = QUOTE(POS_W(37));
                    h = QUOTE(POS_H(13.8));
                };
                class AddonText: RscText {
                    idc = -1;
                    style = ST_RIGHT;
                    text = ECSTRING(main,AddonText);
                    x = QUOTE(POS_W(0.5));
                    y = QUOTE(POS_H(1));
                    w = QUOTE(POS_W(4));
                    h = QUOTE(POS_H(1));
                    sizeEx = QUOTE(POS_H(1));
                };
                class OverwriteClientText: RscText {
                    // Set tooltip per script to avoid it being all upper case.
                    // Disable multiline text to make in unselectable.
                    onLoad = QUOTE((_this select 0) ctrlSetText localize QUOTE(LSTRING(overwrite_clients)); (_this select 0) ctrlEnable false;);
                    idc = IDC_TXT_OVERWRITE_CLIENT;
                    style = QUOTE(ST_MULTI + ST_CENTER);
                    x = QUOTE(POS_W(30));
                    y = QUOTE(POS_H(2));
                    w = QUOTE(POS_W(4));
                    h = QUOTE(POS_H(2*3/4));
                    sizeEx = QUOTE(POS_H(3/4));
                };
                class OverwriteMissionText: OverwriteClientText {
                    onLoad = QUOTE((_this select 0) ctrlSetText localize QUOTE(LSTRING(overwrite_mission)); (_this select 0) ctrlEnable false;);
                    idc = IDC_TXT_OVERWRITE_MISSION;
                    x = QUOTE(POS_W(33));
                };
            };
        };
    };
};

class GVAR(ButtonConfigure_base): RscButtonMenu {
    onButtonClick = QUOTE(ctrlParent (_this select 0) call FUNC(openSettingsMenu));
    idc = IDC_BTN_CONFIGURE;
    text = CSTRING(configureAddons);
    x = QUOTE(POS_X_LOW(11.1));
    y = QUOTE(POS_Y_LOW(23));
    w = QUOTE(POS_W(10));
    h = QUOTE(POS_H(1));
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

class RscControlsGroup;
class RscControlsGroupNoHScrollbars: RscControlsGroup {
    class VScrollbar;
};

class GVAR(OptionsGroup): RscControlsGroupNoHScrollbars {
    x = QUOTE(POS_W(0));
    y = QUOTE(POS_H(3.5));
    w = QUOTE(POS_W(37.5));
    h = QUOTE(POS_H(13.8));
    lineHeight = QUOTE(POS_H(1));

    class VScrollbar: VScrollbar {
        thumb = "\a3\3DEN\Data\Controls\ctrlDefault\thumb_ca.paa";
        border = "\a3\3DEN\Data\Controls\ctrlDefault\border_ca.paa";
        arrowFull = "\a3\3DEN\Data\Controls\ctrlDefault\arrowFull_ca.paa";
        arrowEmpty = "\a3\3DEN\Data\Controls\ctrlDefault\arrowEmpty_ca.paa";
    };
};

class RscCombo {
    class ComboScrollBar;
};

class GVAR(RscCombo): RscCombo {
    arrowFull = "\a3\3DEN\Data\Controls\ctrlCombo\arrowFull_ca.paa";
    arrowEmpty = "\a3\3DEN\Data\Controls\ctrlCombo\arrowEmpty_ca.paa";

    class ComboScrollBar: ComboScrollBar {
        thumb = "\a3\3DEN\Data\Controls\ctrlDefault\thumb_ca.paa";
        border = "\a3\3DEN\Data\Controls\ctrlDefault\border_ca.paa";
        arrowFull = "\a3\3DEN\Data\Controls\ctrlDefault\arrowFull_ca.paa";
        arrowEmpty = "\a3\3DEN\Data\Controls\ctrlDefault\arrowEmpty_ca.paa";
    };
};

// Has to be created dynamically for every options group, because they would
// interfere with the controls groups otherwise. Scripted controls are always
// placed below config controls.
class GVAR(AddonsList): GVAR(RscCombo) {
    linespacing = 1;
    text = "";
    wholeHeight = QUOTE(POS_H(12));
    x = QUOTE(POS_W(4.5));
    y = QUOTE(POS_H(1));
    w = QUOTE(POS_W(21));
    h = QUOTE(POS_H(1));
};

class RscButton;
class RscPicture;

class RscCheckBox;
class GVAR(CheckboxSound): RscCheckBox {
    soundEnter[] = {"\a3\ui_f\data\Sound\RscButtonMenu\soundEnter",0.090000004,1};
    soundPush[] = {"\a3\ui_f\data\Sound\RscButtonMenu\soundPush",0.090000004,1};
    soundClick[] = {"\a3\ui_f\data\Sound\RscButtonMenu\soundClick",0.090000004,1};
    soundEscape[] = {"\a3\ui_f\data\Sound\RscButtonMenu\soundEscape",0.090000004,1};
};

class GVAR(Row_Empty): RscText {
    GVAR(script) = "";
    x = QUOTE(POS_W(1));
    y = QUOTE(POS_H(0));
    w = QUOTE(POS_W(37));
    h = QUOTE(POS_H(0));
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
            idc = IDC_SETTING_NAME;
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
class GVAR(Row_Base): RscControlsGroupNoScrollbars {
    GVAR(script) = "";
    x = QUOTE(POS_W(1));
    y = QUOTE(POS_H(0));
    w = QUOTE(POS_W(37));
    h = QUOTE(POS_H(1) + TABLE_LINE_SPACING);

    class controls {
        class Background: RscText {
            idc = IDC_SETTING_BACKGROUND;
            colorBackground[] = {0,0,0,0.4};
            x = QUOTE(POS_W(0));
            y = QUOTE(POS_H(0) + TABLE_LINE_SPACING/2);
            w = QUOTE(POS_W(36));
            h = QUOTE(POS_H(1));
        };
        class Name: RscText {
            idc = IDC_SETTING_NAME;
            style = ST_RIGHT;
            x = QUOTE(POS_W(0));
            y = QUOTE(POS_H(0) + TABLE_LINE_SPACING/2);
            w = QUOTE(POS_W(15.5));
            h = QUOTE(POS_H(1));
        };
        class Default: RscButton {
            idc = IDC_SETTING_DEFAULT;
            style = ST_PICTURE;
            text = ICON_DEFAULT;
            x = QUOTE(POS_W(27));
            y = QUOTE(POS_H(0) + TABLE_LINE_SPACING/2);
            w = QUOTE(POS_W(1));
            h = QUOTE(POS_H(1));
        };
        class Locked: RscPicture {
            idc = IDC_SETTING_LOCKED;
            x = QUOTE(POS_W(28.5));
            y = QUOTE(POS_H(0) + TABLE_LINE_SPACING/2);
            w = QUOTE(POS_W(1));
            h = QUOTE(POS_H(1));
        };
        class OverwriteClients: GVAR(CheckboxSound) {
            idc = IDC_SETTING_OVERWRITE_CLIENT;
            x = QUOTE(POS_W(30.5));
            y = QUOTE(POS_H(0) + TABLE_LINE_SPACING/2);
            w = QUOTE(POS_W(1));
            h = QUOTE(POS_H(1));
        };
        class OverwriteMission: OverwriteClients {
            idc = IDC_SETTING_OVERWRITE_MISSION;
            x = QUOTE(POS_W(33.5));
        };
    };
};

class GVAR(Row_Checkbox): GVAR(Row_Base) {
    GVAR(script) = QFUNC(gui_settingCheckbox);

    class controls: controls {
        class Name: Name {};
        class Checkbox: GVAR(CheckboxSound) {
            idc = IDC_SETTING_CHECKBOX;
            x = QUOTE(POS_W(16));
            y = QUOTE(POS_H(0) + TABLE_LINE_SPACING/2);
            w = QUOTE(POS_W(1));
            h = QUOTE(POS_H(1));
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
            x = QUOTE(POS_W(16));
            y = QUOTE(POS_H(0) + TABLE_LINE_SPACING/2);
            w = QUOTE(POS_W(10.5));
            h = QUOTE(POS_H(1));
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
        class List: GVAR(RscCombo) {
            idc = IDC_SETTING_LIST;
            x = QUOTE(POS_W(16));
            y = QUOTE(POS_H(0) + TABLE_LINE_SPACING/2);
            w = QUOTE(POS_W(10.5));
            h = QUOTE(POS_H(1));
        };
        class Default: Default {};
        class Locked: Locked {};
        class OverwriteClients: OverwriteClients {};
        class OverwriteMission: OverwriteMission {};
    };
};

class ctrlXSliderH;

class GVAR(Row_Slider): GVAR(Row_Base) {
    GVAR(script) = QFUNC(gui_settingSlider);

    class controls: controls {
        class Name: Name {};
        class Slider: ctrlXSliderH {
            idc = IDC_SETTING_SLIDER;
            x = QUOTE(POS_W(16));
            y = QUOTE(POS_H(0) + TABLE_LINE_SPACING/2);
            w = QUOTE(POS_W(8.2));
            h = QUOTE(POS_H(1));
        };
        class Edit: RscEdit {
            idc = IDC_SETTING_SLIDER_EDIT;
            x = QUOTE(POS_W(24.3));
            y = QUOTE(POS_H(0) + TABLE_LINE_SPACING/2);
            w = QUOTE(POS_W(2.2));
            h = QUOTE(POS_H(1));
        };
        class Default: Default {};
        class Locked: Locked {};
        class OverwriteClients: OverwriteClients {};
        class OverwriteMission: OverwriteMission {};
    };
};

class GVAR(Row_Color): GVAR(Row_Base) {
    GVAR(script) = QFUNC(gui_settingColor);
    h = QUOTE(POS_H(3) + TABLE_LINE_SPACING);

    class controls: controls {
        class Name: Name {
            y = QUOTE(POS_H(0.5) + TABLE_LINE_SPACING/2);
        };
        class Preview: RscText {
            idc = IDC_SETTING_COLOR_PREVIEW;
            x = QUOTE(POS_W(9.5));
            y = QUOTE(POS_H(1.5) + TABLE_LINE_SPACING/2);
            w = QUOTE(POS_W(6));
            h = QUOTE(POS_H(1));
        };
        class Red: ctrlXSliderH {
            idc = IDC_SETTING_COLOR_RED;
            color[] = {1,0,0,0.6};
            colorActive[] = {1,0,0,1};
            colorDisable[] = {1,0,0,0.4};
            x = QUOTE(POS_W(16));
            y = QUOTE(POS_H(0) + TABLE_LINE_SPACING/2);
            w = QUOTE(POS_W(8.2));
            h = QUOTE(POS_H(1));
        };
        class Red_Edit: RscEdit {
            idc = IDC_SETTING_COLOR_RED_EDIT;
            x = QUOTE(POS_W(24.3));
            y = QUOTE(POS_H(0) + TABLE_LINE_SPACING/2);
            w = QUOTE(POS_W(2.2));
            h = QUOTE(POS_H(1));
        };
        class Green: Red {
            idc = IDC_SETTING_COLOR_GREEN;
            color[] = {0,1,0,0.6};
            colorActive[] = {0,1,0,1};
            colorDisable[] = {0,1,0,0.4};
            y = QUOTE(POS_H(1) + TABLE_LINE_SPACING/2);
        };
        class Green_Edit: Red_Edit {
            idc = IDC_SETTING_COLOR_GREEN_EDIT;
            y = QUOTE(POS_H(1) + TABLE_LINE_SPACING/2);
        };
        class Blue: Red {
            idc = IDC_SETTING_COLOR_BLUE;
            color[] = {0,0,1,0.6};
            colorActive[] = {0,0,1,1};
            colorDisable[] = {0,0,1,0.4};
            y = QUOTE(POS_H(2) + TABLE_LINE_SPACING/2);
        };
        class Blue_Edit: Red_Edit {
            idc = IDC_SETTING_COLOR_BLUE_EDIT;
            y = QUOTE(POS_H(2) + TABLE_LINE_SPACING/2);
        };
        class Default: Default {
            y = QUOTE(POS_H(1) + TABLE_LINE_SPACING/2);
        };
        class Locked: Locked {
            y = QUOTE(POS_H(1) + TABLE_LINE_SPACING/2);
        };
        class OverwriteClients: OverwriteClients {
            y = QUOTE(POS_H(1) + TABLE_LINE_SPACING/2);
        };
        class OverwriteMission: OverwriteMission {
            y = QUOTE(POS_H(1) + TABLE_LINE_SPACING/2);
        };
    };
};

class GVAR(Row_ColorAlpha): GVAR(Row_Color) {
    h = QUOTE(POS_H(4) + TABLE_LINE_SPACING);

    class controls: controls {
        class Name: Name {
            y = QUOTE(POS_H(1) + TABLE_LINE_SPACING/2);
        };
        class Preview: Preview {
            y = QUOTE(POS_H(2) + TABLE_LINE_SPACING/2);
        };
        class Red: Red {};
        class Red_Edit: Red_Edit {};
        class Green: Green {};
        class Green_Edit: Green_Edit {};
        class Blue: Blue {};
        class Blue_Edit: Blue_Edit {};
        class Alpha: ctrlXSliderH {
            idc = IDC_SETTING_COLOR_ALPHA;
            x = QUOTE(POS_W(16));
            y = QUOTE(POS_H(3) + TABLE_LINE_SPACING/2);
            w = QUOTE(POS_W(8.2));
            h = QUOTE(POS_H(1));
        };
        class Alpha_Edit: RscEdit {
            idc = IDC_SETTING_COLOR_ALPHA_EDIT;
            x = QUOTE(POS_W(24.3));
            y = QUOTE(POS_H(3) + TABLE_LINE_SPACING/2);
            w = QUOTE(POS_W(2.2));
            h = QUOTE(POS_H(1));
        };
        class Default: Default {
            y = QUOTE(POS_H(1.5) + TABLE_LINE_SPACING/2);
        };
        class Locked: Locked {
            y = QUOTE(POS_H(1.5) + TABLE_LINE_SPACING/2);
        };
        class OverwriteClients: OverwriteClients {
            y = QUOTE(POS_H(1.5) + TABLE_LINE_SPACING/2);
        };
        class OverwriteMission: OverwriteMission {
            y = QUOTE(POS_H(1.5) + TABLE_LINE_SPACING/2);
        };
    };
};

class RscFrame;

class GVAR(Row_Time): GVAR(Row_Base) {
    GVAR(script) = QFUNC(gui_settingTime);
    h = QUOTE(POS_H(2) + TABLE_LINE_SPACING);

    class controls: controls {
        class Name: Name {
            y = QUOTE(POS_H(0.5) + TABLE_LINE_SPACING / 2);
        };
        class Slider: ctrlXSliderH {
            idc = IDC_SETTING_TIME_SLIDER;
            x = QUOTE(POS_W(16));
            y = QUOTE(POS_H(0) + TABLE_LINE_SPACING / 2);
            w = QUOTE(POS_W(10.5));
            h = QUOTE(POS_H(1));
        };
        class Frame: RscFrame {
            x = QUOTE(POS_W(18.25));
            y = QUOTE(POS_H(1.1) + TABLE_LINE_SPACING / 2);
            w = QUOTE(POS_W(6));
            h = QUOTE(POS_H(0.9));
        };
        class Separator: RscText {
            style = ST_CENTER;
            text = ":   :";
            font = "EtelkaMonospaceProBold";
            x = QUOTE(POS_W(18.25));
            y = QUOTE(POS_H(1.1) + TABLE_LINE_SPACING / 2);
            w = QUOTE(POS_W(6));
            h = QUOTE(POS_H(0.9));
            sizeEx = QUOTE(POS_H(1));
            colorBackground[] = {0, 0, 0, 0.2};
        };
        class Hours: RscEdit {
            idc = IDC_SETTING_TIME_HOURS;
            style = QUOTE(ST_CENTER + ST_NO_RECT);
            tooltip = "$STR_3DEN_Attributes_SliderTime_Hour_tooltip";
            font = "EtelkaMonospaceProBold";
            x = QUOTE(POS_W(18.25));
            y = QUOTE(POS_H(1.1) + TABLE_LINE_SPACING / 2);
            w = QUOTE(POS_W(2));
            h = QUOTE(POS_H(0.9));
            sizeEx = QUOTE(POS_H(0.9));
            maxChars = 2;
        };
        class Minutes: Hours {
            idc = IDC_SETTING_TIME_MINUTES;
            tooltip = "$STR_3DEN_Attributes_SliderTime_Minute_tooltip";
            x = QUOTE(POS_W(20.25));
        };
        class Seconds: Hours {
            idc = IDC_SETTING_TIME_SECONDS;
            tooltip = "$STR_3DEN_Attributes_SliderTime_Second_tooltip";
            x = QUOTE(POS_W(22.25));
        };
        class Default: Default {
            y = QUOTE(POS_H(0.5) + TABLE_LINE_SPACING / 2);
        };
        class Locked: Locked {
            y = QUOTE(POS_H(0.5) + TABLE_LINE_SPACING / 2);
        };
        class OverwriteClients: OverwriteClients {
            y = QUOTE(POS_H(0.5) + TABLE_LINE_SPACING / 2);
        };
        class OverwriteMission: OverwriteMission {
            y = QUOTE(POS_H(0.5) + TABLE_LINE_SPACING / 2);
        };
    };
};

class RscTitle;
class RscListBox;

class GVAR(presets) {
    idd = -1;
    movingEnable = 1;
    enableSimulation = 0;

    class controls {
        class Presets: RscControlsGroup {
            idc = IDC_PRESETS_GROUP;
            x = QUOTE(POS_X(10));
            y = QUOTE(POS_Y(0.9));
            w = QUOTE(POS_W(20));
            h = QUOTE(POS_H(22.2));

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
                    x = QUOTE(POS_W(0));
                    y = QUOTE(POS_H(0));
                    w = QUOTE(POS_W(20));
                    h = QUOTE(POS_H(1));
                };
                class Background: RscText {
                    idc = -1;
                    colorBackground[] = {0,0,0,0.8};
                    x = QUOTE(POS_W(0));
                    y = QUOTE(POS_H(1.1));
                    w = QUOTE(POS_W(20));
                    h = QUOTE(POS_H(20));
                };
                class TextName: RscText {
                    idc = IDC_PRESETS_NAME;
                    style = ST_RIGHT;
                    text = "$STR_DISP_INTEL_NAME";
                    x = QUOTE(POS_W(0.5));
                    y = QUOTE(POS_H(19.6));
                    w = QUOTE(POS_W(5.5));
                    h = QUOTE(POS_H(1));
                    sizeEx = QUOTE(POS_H(0.8));
                };
                class EditName: RscEdit {
                    idc = IDC_PRESETS_EDIT;
                    x = QUOTE(POS_W(6));
                    y = QUOTE(POS_H(19.6));
                    w = QUOTE(POS_W(13.5));
                    h = QUOTE(POS_H(1));
                    sizeEx = QUOTE(POS_H(0.8));
                };
                class ValueName: RscListBox {
                    idc = IDC_PRESETS_VALUE;
                    colorBackground[] = {1,1,1,0.2};
                    x = QUOTE(POS_W(0.5));
                    y = QUOTE(POS_H(1.6));
                    w = QUOTE(POS_W(19));
                    h = QUOTE(POS_H(17.5));
                    sizeEx = QUOTE(POS_H(0.8));
                };
                class ButtonOK: RscButtonMenu {
                    idc = IDC_PRESETS_OK;
                    text = "$STR_DISP_OK";
                    x = QUOTE(POS_W(15));
                    y = QUOTE(POS_H(21.2));
                    w = QUOTE(POS_W(5));
                    h = QUOTE(POS_H(1));
                };
                class ButtonCancel: RscButtonMenu {
                    idc = IDC_PRESETS_CANCEL;
                    text = "$STR_DISP_CANCEL";
                    x = QUOTE(POS_W(0));
                    y = QUOTE(POS_H(21.2));
                    w = QUOTE(POS_W(5));
                    h = QUOTE(POS_H(1));
                };
                class ButtonDelete: RscButtonMenu {
                    idc = IDC_PRESETS_DELETE;
                    text = "$STR_DISP_DELETE";
                    x = QUOTE(POS_W(9.9));
                    y = QUOTE(POS_H(21.2));
                    w = QUOTE(POS_W(5));
                    h = QUOTE(POS_H(1));
                };
            };
        };
    };
};

class RscDisplayEmpty;
class GVAR(MainMenuHelper): RscDisplayEmpty {
    onLoad = QUOTE(\
        (_this select 0) call FUNC(openSettingsMenu);\
        (_this select 0) closeDisplay 0;\
    );
};

class GVAR(export) {
    idd = -1;
    movingEnable = 1;
    enableSimulation = 0;

    class controls {
        class Presets: RscControlsGroup {
            idc = IDC_EXPORT_GROUP;
            x = QUOTE(POS_X(5));
            y = QUOTE(POS_Y(-5.1));
            w = QUOTE(POS_W(30));
            h = QUOTE(POS_H(32.2));

            class controls {
                class Title: RscTitle {
                    colorBackground[] = {
                        "(profileNamespace getVariable ['GUI_BCG_RGB_R',0.77])",
                        "(profileNamespace getVariable ['GUI_BCG_RGB_G',0.51])",
                        "(profileNamespace getVariable ['GUI_BCG_RGB_B',0.08])",
                        "(profileNamespace getVariable ['GUI_BCG_RGB_A',0.8])"
                    };
                    idc = IDC_EXPORT_TITLE;
                    text = "";
                    x = QUOTE(POS_W(0));
                    y = QUOTE(POS_H(0));
                    w = QUOTE(POS_W(30));
                    h = QUOTE(POS_H(1));
                };
                class Background: RscText {
                    idc = -1;
                    colorBackground[] = {0,0,0,0.8};
                    x = QUOTE(POS_W(0));
                    y = QUOTE(POS_H(1.1));
                    w = QUOTE(POS_W(30));
                    h = QUOTE(POS_H(30));
                };
                class ValueGroup: RscControlsGroup {
                    idc = IDC_EXPORT_VALUE_GROUP;
                    x = QUOTE(POS_W(0.5));
                    y = QUOTE(POS_H(1.6));
                    w = QUOTE(POS_W(29));
                    h = QUOTE(POS_H(29));

                    class controls {
                        class Value: RscEdit {
                            idc = IDC_EXPORT_VALUE;
                            style = QUOTE(ST_MULTI + ST_NO_RECT);
                            colorDisabled[] = {0.95,0.95,0.95,1};
                            colorBackground[] = {1,1,1,0.2};
                            x = QUOTE(POS_W(0));
                            y = QUOTE(POS_H(0));
                            w = QUOTE(POS_W(29));
                            h = QUOTE(POS_H(29));
                            sizeEx = QUOTE(POS_H(0.8));
                        };
                    };
                };
                class ButtonOK: RscButtonMenu {
                    idc = IDC_EXPORT_OK;
                    text = "$STR_DISP_OK";
                    x = QUOTE(POS_W(20));
                    y = QUOTE(POS_H(31.2));
                    w = QUOTE(POS_W(10));
                    h = QUOTE(POS_H(1));
                };
                class ButtonCancel: RscButtonMenu {
                    idc = IDC_EXPORT_CANCEL;
                    text = "$STR_DISP_CANCEL";
                    x = QUOTE(POS_W(0));
                    y = QUOTE(POS_H(31.2));
                    w = QUOTE(POS_W(10));
                    h = QUOTE(POS_H(1));
                };
                class ToggleDefaultText: RscText {
                    idc = IDC_EXPORT_TOGGLE_DEFAULT_TEXT;
                    style = ST_RIGHT;
                    text = CSTRING(show_default);
                    x = QUOTE(POS_W(19));
                    y = QUOTE(POS_H(0));
                    w = QUOTE(POS_W(10));
                    h = QUOTE(POS_H(1));
                };
                class ToggleDefault: GVAR(CheckboxSound) {
                    idc = IDC_EXPORT_TOGGLE_DEFAULT;
                    x = QUOTE(POS_W(29));
                    y = QUOTE(POS_H(0));
                    w = QUOTE(POS_W(1));
                    h = QUOTE(POS_H(1));
                };
            };
        };
    };
};
