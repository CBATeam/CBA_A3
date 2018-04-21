class RscText;
class RscProgress;

class GVAR(ProgressBar) {
    idd = -1;
    controls[] = {"Background", "TitleBackground", "ProgressBar", "TitleText"};

    class Background: RscText {
        x = "safezoneXAbs";
        y = "safezoneY";
        w = "safezoneWAbs";
        h = "safezoneH";
    };

    class TitleBackground: RscText {
        style = ST_CENTER;
        sizeEx = 1 * GUI_GRID_CENTER_H;
        colorBackground[] = {0,0,0,0.5};
        x = 1 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 0 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 38 * GUI_GRID_CENTER_W;
        h = 1 * GUI_GRID_CENTER_H;
    };

    class TitleText: TitleBackground {
        idc = IDC_PROGRESSBAR_TITLE;
        colorBackground[] = {0,0,0,0};
        colorText[] = {1,1,1,1};
    };

    class ProgressBar: RscProgress {
        idc = IDC_PROGRESSBAR_BAR;
        colorFrame[] = {0,0,0,0.5};
        colorBar[] = GUI_BCG_COLOR;
        texture = "#(argb,8,8,3)color(1,1,1,0.7)";
        x = 1 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
        y = 0 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
        w = 38 * GUI_GRID_CENTER_W;
        h = 1 * GUI_GRID_CENTER_H;
    };
};
