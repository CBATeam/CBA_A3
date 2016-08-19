
class RscStructuredText;

class RscTitles {
    class GVAR(Error) {
        idd = -1;
        duration = 5;
        fadeIn = 0;
        fadeOut = 0.5;
        movingEnable = 0;

        class Controls {
            class GVAR(Error): RscStructuredText {
                onLoad = QUOTE(uiNamespace setVariable [ARR_2('GVAR(Error)',_this select 0)]);
                idc = -1;
                font = "RobotoCondensedBold";
                sizeEx = 0.55 * GUI_GRID_CENTER_H;
                x =  0 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
                y =  0 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
                w = 40 * GUI_GRID_CENTER_W;
                h = 10 * GUI_GRID_CENTER_H;
                colorBackground[] = {1,0.4,0,0.8};
            };
        };
    };
};
