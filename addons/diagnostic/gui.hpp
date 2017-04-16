
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
                sizeEx = 0.55 * GUI_GRID_CENTER_H;
                x =  0 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
                y =  5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
                w = 40 * GUI_GRID_CENTER_W;
                h = 10 * GUI_GRID_CENTER_H;
                colorBackground[] = {1,0.2,0,0.8};
            };
        };
    };
};

// debug console in virtual arsenal
class RscControlsGroupNoScrollbars;

class RscStandardDisplay;
class RscDisplayMain: RscStandardDisplay {
    class controls {
        class GroupSingleplayer: RscControlsGroupNoScrollbars {
            class Controls;
        };

        class GroupTutorials: GroupSingleplayer {
            class Controls: Controls {
                class Bootcamp;
                class Arsenal: Bootcamp {
                    onButtonClick = QUOTE(playMission [ARR_2('','PATHTOF(Scenarios\Arsenal.VR)')]);
                };
            };
        };
    };
};
