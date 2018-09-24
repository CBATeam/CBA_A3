#define WIDTH (24.1 * GUI_GRID_W)
#define HEIGHT (22.2 * GUI_GRID_H)

class GVAR(GroupManager) {
    idd = -1;
    movingEnable = 1;

    class controls {
        class Presets: RscControlsGroup {
            idc = IDC_PRESETS_GROUP;
            x = 0.5 - WIDTH/2;
            y = 0.5 - HEIGHT/2;
            w = WIDTH;
            h = HEIGHT;

            class controls {
                class Title: RscTitle {
                    colorBackground[] = {
                        "(profileNamespace getVariable ['GUI_BCG_RGB_R',0.77])",
                        "(profileNamespace getVariable ['GUI_BCG_RGB_G',0.51])",
                        "(profileNamespace getVariable ['GUI_BCG_RGB_B',0.08])",
                        "(profileNamespace getVariable ['GUI_BCG_RGB_A',0.8])"
                    };
                    idc = -1;
                    moving = 1;
                    text = "Group Manager"; // @todo translate
                    x = 0 * GUI_GRID_W;
                    y = 0 * GUI_GRID_H;
                    w = WIDTH;
                    h = 1 * GUI_GRID_H;
                };
                class Background: RscText {
                    idc = -1;
                    colorBackground[] = {0,0,0,0.8};
                    x = 0 * GUI_GRID_W;
                    y = 1.1 * GUI_GRID_H;
                    w = WIDTH;
                    h = 20 * GUI_GRID_H;
                };
                class Groups: RscListBox {
                    idc = IDC_GM_GROUPS;
                    //colorBackground[] = {1,1,1,0.2};
                    x = 0 * GUI_GRID_W;
                    y = 1.1 * GUI_GRID_H;
                    w = 12 * GUI_GRID_W;
                    h = 17 * GUI_GRID_H;
                };
                class Units: Groups {
                    idc = IDC_GM_UNITS;
                    x = 12.1 * GUI_GRID_W;
                };
                class Group_ButtonUp: RscButtonMenu {
                    idc = IDC_GM_GROUPS_UP;
                    text = QPATHTOF(arrow_up_ca.paa);
                    x = 0 * GUI_GRID_W;
                    y = 18.1 * GUI_GRID_H;
                    w = 1 * GUI_GRID_W;
                    h = 1 * GUI_GRID_H;
                };
                class Group_ButtonDown: Group_ButtonUp {
                    idc = IDC_GM_GROUPS_DOWN;
                    text = QPATHTOF(arrow_down_ca.paa);
                    y = 19.1 * GUI_GRID_H;
                };
                class Group_Name: RscEdit {
                    idc = IDC_GM_GROUPS_NAME;
                    x = 1 * GUI_GRID_W;
                    y = 18.1 * GUI_GRID_H;
                    w = 11 * GUI_GRID_W;
                    h = 1 * GUI_GRID_H;
                };
                class Group_VarName: Group_Name {
                    idc = IDC_GM_GROUPS_VARNAME;
                    x = 1 * GUI_GRID_W;
                    y = 19.1 * GUI_GRID_H;
                };
                class Unit_ButtonUp: Group_ButtonUp {
                    idc = IDC_GM_UNITS_UP;
                    x = 12.1 * GUI_GRID_W;
                };
                class Unit_ButtonDown: Group_ButtonDown {
                    idc = IDC_GM_UNITS_DOWN;
                    x = 12.1 * GUI_GRID_W;
                };
                class Unit_Name: Group_Name {
                    idc = IDC_GM_GROUPS_NAME;
                    x = 13.1 * GUI_GRID_W;
                };
                class Unit_VarName: Group_VarName {
                    idc = IDC_GM_GROUPS_VARNAME;
                    x = 13.1 * GUI_GRID_W;
                };
                class ButtonOK: RscButtonMenuOK {
                    x = WIDTH - 10.1 * GUI_GRID_W;
                    y = HEIGHT - 1 * GUI_GRID_H;
                    w = 5 * GUI_GRID_W;
                    h = 1 * GUI_GRID_H;
                };
                class ButtonCancel: RscButtonMenuCancel {
                    x = WIDTH - 5 * GUI_GRID_W;
                    y = HEIGHT - 1 * GUI_GRID_H;
                    w = 5 * GUI_GRID_W;
                    h = 1 * GUI_GRID_H;
                };
            };
        };
    };
};
