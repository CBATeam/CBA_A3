class RscStructuredText;

class RscTitles {
    class GVAR(Error) {
        idd = -1;
        duration = 10;
        fadeIn = 0;
        fadeOut = 0.5;
        movingEnable = 0;

        class Controls {
            class GVAR(Error): RscStructuredText {
                onLoad = QUOTE(uiNamespace setVariable [ARR_2('GVAR(Error)',_this select 0)]);
                idc = -1;
                font = "RobotoCondensedBold";
                sizeEx = QUOTE(0.55 * GUI_GRID_CENTER_H);
                x = QUOTE(0 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
                y = QUOTE(5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
                w = QUOTE(40 * GUI_GRID_CENTER_W);
                h = QUOTE(10 * GUI_GRID_CENTER_H);
                colorBackground[] = {1,0.2,0,0.8};
            };
        };
    };
};

class RscEdit;
class GVAR(watchInput): RscEdit {
    autocomplete = "scripting";
    shadow = 0;
    font = "EtelkaMonospacePro";
    x = QUOTE(0.5 * GUI_GRID_W);
    y = QUOTE(11 * GUI_GRID_H);
    w = QUOTE(21 * GUI_GRID_W);
    h = QUOTE(1 * GUI_GRID_H);
    sizeEx = QUOTE(0.7 * GUI_GRID_H);
};

class GVAR(watchOutput): RscEdit {
    lineSpacing = 1;
    style = ST_NO_RECT;
    shadow = 0;
    font = "EtelkaMonospacePro";
    x = QUOTE(0.5 * GUI_GRID_W);
    y = QUOTE(12 * GUI_GRID_H);
    w = QUOTE(21 * GUI_GRID_W);
    h = QUOTE(1 * GUI_GRID_H);
    colorBackground[] = {0,0,0,0.75};
    sizeEx = QUOTE(0.7 * GUI_GRID_H);
};

class RscCheckBox;
class RscControlsGroupNoScrollbars;
class RscDebugConsole: RscControlsGroupNoScrollbars {
    class controls {
        class WatchInput1: RscEdit {
            onKillFocus = QUOTE([ARR_2('killFocus',_this)] call FUNC(watchInput););
            onLoad = QUOTE([ARR_2('load',_this)] call FUNC(watchInput););
        };
        class WatchInput1View: RscCheckBox {
            idc = IDC_DEBUGCONSOLE_WATCHINPUT_1;
            onLoad = QUOTE([ARR_2('loadCheckbox',_this)] call FUNC(watchInput););
            y = QUOTE(11 * GUI_GRID_H);
            h = QUOTE(1 * GUI_GRID_H);
            w = QUOTE(1 * GUI_GRID_W);
            x = QUOTE(20 * GUI_GRID_W);
            resizeFlags = 1;
            alwaysVisible = 1;
            textureChecked = QPATHTOF(data\monitor_on_ca.paa);
            textureUnchecked = QPATHTOF(data\monitor_off_ca.paa);
            textureFocusedChecked = QPATHTOF(data\monitor_on_ca.paa);
            textureFocusedUnchecked = QPATHTOF(data\monitor_off_ca.paa);
            textureHoverChecked = QPATHTOF(data\monitor_on_ca.paa);
            textureHoverUnchecked = QPATHTOF(data\monitor_off_ca.paa);
            texturePressedChecked = QPATHTOF(data\monitor_on_ca.paa);
            texturePressedUnchecked = QPATHTOF(data\monitor_off_ca.paa);
            onCheckedChanged = QUOTE([ARR_2('checked',_this)] call FUNC(watchInput));
        };
        class WatchInputView2: WatchInput1View {
            idc = IDC_DEBUGCONSOLE_WATCHINPUT_2;
            y = QUOTE(13 * GUI_GRID_H);
        };
        class WatchInputView3: WatchInput1View {
            idc = IDC_DEBUGCONSOLE_WATCHINPUT_3;
            y = QUOTE(15 * GUI_GRID_H);
        };
        class WatchInputView4: WatchInput1View {
            idc = IDC_DEBUGCONSOLE_WATCHINPUT_4;
            y = QUOTE(17 * GUI_GRID_H);
        };
    };
};

class RscText;
class GVAR(watchedInput): RscControlsGroupNoScrollbars {
    idc = -1;
    class controls {
        class Background: RscText {
            colorBackground[] = {0, 0, 0, 0.6};
            x = QUOTE(0.1 * GUI_GRID_W);
            y = QUOTE(0.1 * GUI_GRID_H);
            w = QUOTE(15 * GUI_GRID_W);
            h = QUOTE(1.8 * GUI_GRID_H);
        };
        class Expression: RscText {
            sizeEx = QUOTE(0.75 * GUI_GRID_H);
            font = "EtelkaMonospacePro";
            shadow = 1;
            colorText[] = {1, 1, 1, 1};
            colorBackground[] = {0, 0, 0, 0};
            text = "Expression";
            x = QUOTE(0.1 * GUI_GRID_W);
            y = QUOTE(0.1 * GUI_GRID_H);
            w = QUOTE(15 * GUI_GRID_W);
            h = QUOTE(0.8 * GUI_GRID_H);
        };
        class Result: Expression {
            style = 0;
            text = "Result";
            x = QUOTE(0.1 * GUI_GRID_W);
            y = QUOTE(0.9 * GUI_GRID_H);
            w = QUOTE(15 * GUI_GRID_W);
            h = QUOTE(1 * GUI_GRID_H);
        };
    };
};
