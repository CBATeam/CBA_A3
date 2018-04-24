class RscControlsGroupNoScrollbars;
class RscText;
class RscProgress;

class GVAR(ProgressBar): RscControlsGroupNoScrollbars {
    x = "safezoneXAbs";
    y = "safezoneY";
    w = "safezoneWAbs";
    h = "safezoneH";

    class controls {
        class TitleBackground: RscText {
            idc = IDC_PROGRESSBAR_BACKGROUND;
            style = ST_CENTER;
            sizeEx = 1 * GUI_GRID_CENTER_H;
            colorBackground[] = {0,0,0,0.5};
            x = profileNamespace getVariable ['TRIPLES(IGUI,GVAR(grid),X)', 0];
            y = profileNamespace getVariable ['TRIPLES(IGUI,GVAR(grid),Y)', 0];
            w = profileNamespace getVariable ['TRIPLES(IGUI,GVAR(grid),W)', 0];
            h = profileNamespace getVariable ['TRIPLES(IGUI,GVAR(grid),H)', 0];
        };

        class ProgressBar: RscProgress {
            idc = IDC_PROGRESSBAR_BAR;
            colorFrame[] = {0,0,0,0.5};
            colorBar[] = GUI_BCG_COLOR;
            texture = "#(argb,8,8,3)color(1,1,1,0.7)";
            x = profileNamespace getVariable ['TRIPLES(IGUI,GVAR(grid),X)', 0];
            y = profileNamespace getVariable ['TRIPLES(IGUI,GVAR(grid),Y)', 0];
            w = profileNamespace getVariable ['TRIPLES(IGUI,GVAR(grid),W)', 0];
            h = profileNamespace getVariable ['TRIPLES(IGUI,GVAR(grid),H)', 0];
        };

        class TitleText: TitleBackground {
            idc = IDC_PROGRESSBAR_TITLE;
            colorBackground[] = {0,0,0,0};
            colorText[] = {1,1,1,1};
        };
    };
};
