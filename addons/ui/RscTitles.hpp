class RscTitles {
    class GVAR(ProgressBar) {
        onLoad = QUOTE(with uiNameSpace do { GVAR(ProgressBar) = _this select 0 }; );
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
            // idc = IDC_PROGRESSBAR_BACKGROUND;
            style = ST_CENTER;
            sizeEx = QUOTE(1 * GUI_GRID_CENTER_H);
            colorBackground[] = {0,0,0,0.5};
            x = QUOTE(profileNamespace getVariable [ARR_2(QUOTE(QUOTE(TRIPLES(IGUI,GVAR(grid),X))), 0)]);
            y = QUOTE(profileNamespace getVariable [ARR_2(QUOTE(QUOTE(TRIPLES(IGUI,GVAR(grid),Y))), 0)]);
            w = QUOTE(profileNamespace getVariable [ARR_2(QUOTE(QUOTE(TRIPLES(IGUI,GVAR(grid),W))), 0)]);
            h = QUOTE(profileNamespace getVariable [ARR_2(QUOTE(QUOTE(TRIPLES(IGUI,GVAR(grid),H))), 0)]);
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
            x = QUOTE(profileNamespace getVariable [ARR_2(QUOTE(QUOTE(TRIPLES(IGUI,GVAR(grid),X))), 0)]);
            y = QUOTE(profileNamespace getVariable [ARR_2(QUOTE(QUOTE(TRIPLES(IGUI,GVAR(grid),Y))), 0)]);
            w = QUOTE(profileNamespace getVariable [ARR_2(QUOTE(QUOTE(TRIPLES(IGUI,GVAR(grid),W))), 0)]);
            h = QUOTE(profileNamespace getVariable [ARR_2(QUOTE(QUOTE(TRIPLES(IGUI,GVAR(grid),H))), 0)]);
        };

        class Script: RscMapControl {
            idc = IDC_PROGRESSBAR_SCRIPT;
            w = 0;
            h = 0;
        };
    };
};
