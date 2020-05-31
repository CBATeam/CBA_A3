class RscText;
class RscProgress;
class RscMapControl;

class RscListBox;
class GVAR(ItemContextMenu): RscListBox {
    colorBackground[] = {0.05,0.05,0.05,0.95};
};

class RscTitles {
    class GVAR(ProgressBar) {
        onLoad = uiNamespace setVariable ['GVAR(ProgressBar)', _this select 0];
        idd = -1;
        duration = 1e+11;
        fadeIn = 0;
        fadeOut = 0;

        controls[] = {"Background", "TitleBackground", "ProgressBar", "TitleText", "Script"};

        class Background: RscText {
            colorBackground[] = {0,0,0,0};
            x = "safezoneXAbs";
            y = "safezoneY";
            w = "safezoneWAbs";
            h = "safezoneH";
        };

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
            x = profileNamespace getVariable ['TRIPLES(IGUI,GVAR(grid),X)', 0];
            y = profileNamespace getVariable ['TRIPLES(IGUI,GVAR(grid),Y)', 0];
            w = profileNamespace getVariable ['TRIPLES(IGUI,GVAR(grid),W)', 0];
            h = profileNamespace getVariable ['TRIPLES(IGUI,GVAR(grid),H)', 0];
        };

        class Script: RscMapControl {
            idc = IDC_PROGRESSBAR_SCRIPT;
            w = 0;
            h = 0;
        };
    };
};
