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
                class Slots: RscListBox {
                    idc = IDC_LM_SLOTS;
                    //colorBackground[] = {1,1,1,0.2};
                    x = 0 * GUI_GRID_W;
                    y = 1.1 * GUI_GRID_H;
                    w = 12 * GUI_GRID_W;
                    h = 19.9 * GUI_GRID_H;
                };
                class ButtonUp: ctrlButtonPicture {
                    idc = IDC_LM_MOVE_UP;
                    text = QPATHTOF(arrow_up_ca.paa);
                    x = 12.1 * GUI_GRID_W;
                    y = 1.1 * GUI_GRID_H;
                    w = 1 * GUI_GRID_W;
                    h = 1 * GUI_GRID_H;
                };
                class ButtonDown: ButtonUp {
                    idc = IDC_LM_MOVE_DOWN;
                    text = QPATHTOF(arrow_down_ca.paa);
                    y = 2.1 * GUI_GRID_H;
                };
                class Name: RscText {
                    text = "$STR_3DEN_OBJECT_ATTRIBUTE_DESCRIPTION_DISPLAYNAME";
                    tooltip = "$STR_3DEN_OBJECT_ATTRIBUTE_DESCRIPTION_TOOLTIP";
                    sizeEx = 0.7 * GUI_GRID_H;
                    x = 12.1 * GUI_GRID_W;
                    y = 3.5 * GUI_GRID_H;
                    w = 12 * GUI_GRID_W;
                    h = 0.7 * GUI_GRID_H;
                };
                class ValueName: RscEdit {
                    idc = IDC_LM_NAME;
                    x = 12.1 * GUI_GRID_W;
                    y = 4.2 * GUI_GRID_H;
                    w = 12 * GUI_GRID_W;
                    h = 1 * GUI_GRID_H;
                };
                class VarName: Name {
                    text = "$STR_3DEN_OBJECT_ATTRIBUTE_NAME_DISPLAYNAME";
                    tooltip = "$STR_3DEN_OBJECT_ATTRIBUTE_NAME_TOOLTIP";
                    y = 5.5 * GUI_GRID_H;
                };
                class ValueVarName: ValueName {
                    idc = IDC_LM_VARNAME;
                    y = 6.2 * GUI_GRID_H;
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
