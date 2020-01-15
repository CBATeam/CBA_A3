class GVAR(LobbyManager) {
    idd = -1;
    enableDisplay = 1;
    movingEnable = 1;

    class controlsBackground {
        class Disable: ctrlStaticBackgroundDisable {};
        class DisableTiles: ctrlStaticBackgroundDisableTiles {};
    };

    class controls {
        class Background: ctrlStaticBackground {
            x = (getResolution select 2) * 0.5 * pixelW - (140/2) * GRID_3DEN_W;
            y = 0.5 - (120/2 - 5) * GRID_3DEN_H;
            w = 140 * GRID_3DEN_W;
            h = (120 - 10) * GRID_3DEN_H;
        };
        class BackgroundButtons: ctrlStaticFooter {
            x = (getResolution select 2) * 0.5 * pixelW - (140/2) * GRID_3DEN_W;
            y = 0.5 + (120/2 - 10 - 2) * GRID_3DEN_H;
            w = 140 * GRID_3DEN_W;
            h = 7 * GRID_3DEN_H;
        };
        class Title: ctrlStaticTitle {
            text = CSTRING(LobbyManager);
            x = (getResolution select 2) * 0.5 * pixelW - (140/2) * GRID_3DEN_W;
            y = 0.5 - (120/2 - 5) * GRID_3DEN_H;
            w = 140 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };
        class Slots: ctrlTree {
            idc = IDC_LM_SLOTS;
            x = (getResolution select 2) * 0.5 * pixelW - (140/2 - 1) * GRID_3DEN_W;
            y = 0.5 - (120/2 - 10 - 1) * GRID_3DEN_H;
            w = 88 * GRID_3DEN_W;
            h = (120 - 10 - 5 - 7 - 2) * GRID_3DEN_H;
            sizeEx = 3.96 * (1 / (getResolution select 3)) * pixelGrid * 0.5;
            colorBackground[] = {0, 0, 0, 0.3};
            disableKeyboardSearch = 1;
        };
        class CallsignLabel: ctrlStatic {
            text = "$STR_3DEN_Group_Attribute_Callsign_displayName";
            tooltip = "$STR_3DEN_Group_Attribute_Callsign_tooltip";
            x = (getResolution select 2) * 0.5 * pixelW + (140/2 - 50) * GRID_3DEN_W;
            y = 0.5 - (120/2 - 10 - 1) * GRID_3DEN_H;
            w = 49 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };
        class Callsign: ctrlEdit {
            idc = IDC_LM_CALLSIGN;
            onLoad = QUOTE((_this select 0) ctrlEnable false);
            x = (getResolution select 2) * 0.5 * pixelW + (140/2 - 50) * GRID_3DEN_W;
            y = 0.5 - (120/2 - 10 - 1 - 5) * GRID_3DEN_H;
            w = 49 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
            colorDisabled[] = {1, 1, 1, 1};
            colorBackground[] = {0, 0, 0, 0.25};
        };
        class DescriptionLabel: CallsignLabel {
            text = "$STR_3DEN_Object_Attribute_Description_displayName";
            tooltip = "$STR_3DEN_Object_Attribute_Description_tooltip";
            y = 0.5 - (120/2 - 10 - 1 - 10) * GRID_3DEN_H;
        };
        class Description: Callsign {
            idc = IDC_LM_DESCRIPTION;
            y = 0.5 - (120/2 - 10 - 1 - 5 - 10) * GRID_3DEN_H;
        };
        class MoveUp: ctrlButtonPictureKeepAspect {
            idc = IDC_LM_MOVE_UP;
            text = QPATHTOF(arrow_up_ca.paa);
            tooltip = "$STR_USRACT_CAMERA_MOVE_UP";
            x = (getResolution select 2) * 0.5 * pixelW + (140/2 - 50) * GRID_3DEN_W;
            y = 0.5 + (120/2 - 10 - 7 - 1) * GRID_3DEN_H;
            w = 5 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
            colorBackground[] = {0, 0, 0, 0};
        };
        class MoveDown: MoveUp {
            idc = IDC_LM_MOVE_DOWN;
            text = QPATHTOF(arrow_down_ca.paa);
            tooltip = "$STR_USRACT_CAMERA_MOVE_DOWN";
            x = (getResolution select 2) * 0.5 * pixelW + (140/2 - 50 + 5) * GRID_3DEN_W;
        };
        class Collapse: ctrlButtonCollapseAll {
            idc = IDC_LM_COLLAPSE;
            x = (getResolution select 2) * 0.5 * pixelW + (140/2 - 50 + 10) * GRID_3DEN_W;
            y = 0.5 + (120/2 - 10 - 7 - 1) * GRID_3DEN_H;
            w = 5 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };
        class Expand: ctrlButtonExpandAll {
            idc = IDC_LM_EXPAND;
            x = (getResolution select 2) * 0.5 * pixelW + (140/2 - 50 + 15) * GRID_3DEN_W;
            y = 0.5 + (120/2 - 10 - 7 - 1) * GRID_3DEN_H;
            w = 5 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };
        class ButtonOK: ctrlButtonOK {
            x = (getResolution select 2) * 0.5 * pixelW + (140/2 - 50 - 2) * GRID_3DEN_W;
            y = 0.5 + (120/2 - 10 - 1) * GRID_3DEN_H;
            w = 25 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };
        class ButtonCancel: ctrlButtonCancel {
            x = (getResolution select 2) * 0.5 * pixelW + (140/2 - 25 - 1) * GRID_3DEN_W;
            y = 0.5 + (120/2 - 10 - 1) * GRID_3DEN_H;
            w = 25 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };
    };
};
