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
                x = QUOTE( 0 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
                y = QUOTE( 5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
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
