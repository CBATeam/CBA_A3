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
            x = QUOTE((getResolution select 2) * 0.5 * pixelW - (140/2) * GRID_3DEN_W);
            y = QUOTE(0.5 - (120/2 - 5) * GRID_3DEN_H);
            w = QUOTE(140 * GRID_3DEN_W);
            h = QUOTE((120 - 10) * GRID_3DEN_H);
        };
        class BackgroundButtons: ctrlStaticFooter {
            x = QUOTE((getResolution select 2) * 0.5 * pixelW - (140/2) * GRID_3DEN_W);
            y = QUOTE(0.5 + (120/2 - 10 - 2) * GRID_3DEN_H);
            w = QUOTE(140 * GRID_3DEN_W);
            h = QUOTE(7 * GRID_3DEN_H);
        };
        class Title: ctrlStaticTitle {
            text = CSTRING(LobbyManager);
            x = QUOTE((getResolution select 2) * 0.5 * pixelW - (140/2) * GRID_3DEN_W);
            y = QUOTE(0.5 - (120/2 - 5) * GRID_3DEN_H);
            w = QUOTE(140 * GRID_3DEN_W);
            h = QUOTE(5 * GRID_3DEN_H);
        };
        class Slots: ctrlTree {
            idc = IDC_LM_SLOTS;
            x = QUOTE((getResolution select 2) * 0.5 * pixelW - (140/2 - 1) * GRID_3DEN_W);
            y = QUOTE(0.5 - (120/2 - 10 - 1) * GRID_3DEN_H);
            w = QUOTE(88 * GRID_3DEN_W);
            h = QUOTE((120 - 10 - 5 - 7 - 2) * GRID_3DEN_H);
            sizeEx = QUOTE(3.96 * (1 / (getResolution select 3)) * pixelGrid * 0.5);
            colorBackground[] = {0, 0, 0, 0.3};
            disableKeyboardSearch = QUOTE(1);
        };
        class CallsignLabel: ctrlStatic {
            text = "$STR_3DEN_Group_Attribute_Callsign_displayName";
            tooltip = "$STR_3DEN_Group_Attribute_Callsign_tooltip";
            x = QUOTE((getResolution select 2) * 0.5 * pixelW + (140/2 - 50) * GRID_3DEN_W);
            y = QUOTE(0.5 - (120/2 - 10 - 1) * GRID_3DEN_H);
            w = QUOTE(49 * GRID_3DEN_W);
            h = QUOTE(5 * GRID_3DEN_H);
        };
        class Callsign: ctrlEdit {
            idc = IDC_LM_CALLSIGN;
            onLoad = QUOTE((_this select 0) ctrlEnable false);
            x = QUOTE((getResolution select 2) * 0.5 * pixelW + (140/2 - 50) * GRID_3DEN_W);
            y = QUOTE(0.5 - (120/2 - 10 - 1 - 5) * GRID_3DEN_H);
            w = QUOTE(49 * GRID_3DEN_W);
            h = QUOTE(5 * GRID_3DEN_H);
            colorDisabled[] = {1, 1, 1, 1};
            colorBackground[] = {0, 0, 0, 0.25};
        };
        class DescriptionLabel: CallsignLabel {
            text = "$STR_3DEN_Object_Attribute_Description_displayName";
            tooltip = "$STR_3DEN_Object_Attribute_Description_tooltip";
            y = QUOTE(0.5 - (120/2 - 10 - 1 - 10) * GRID_3DEN_H);
        };
        class Description: Callsign {
            idc = IDC_LM_DESCRIPTION;
            y = QUOTE(0.5 - (120/2 - 10 - 1 - 5 - 10) * GRID_3DEN_H);
        };
        class MoveUp: ctrlButtonPictureKeepAspect {
            idc = IDC_LM_MOVE_UP;
            text = QPATHTOF(arrow_up_ca.paa);
            tooltip = "$STR_USRACT_CAMERA_MOVE_UP";
            x = QUOTE((getResolution select 2) * 0.5 * pixelW + (140/2 - 50) * GRID_3DEN_W);
            y = QUOTE(0.5 + (120/2 - 10 - 7 - 1) * GRID_3DEN_H);
            w = QUOTE(5 * GRID_3DEN_W);
            h = QUOTE(5 * GRID_3DEN_H);
            colorBackground[] = {0, 0, 0, 0};
        };
        class MoveDown: MoveUp {
            idc = IDC_LM_MOVE_DOWN;
            text = QPATHTOF(arrow_down_ca.paa);
            tooltip = "$STR_USRACT_CAMERA_MOVE_DOWN";
            x = QUOTE((getResolution select 2) * 0.5 * pixelW + (140/2 - 50 + 5) * GRID_3DEN_W);
        };
        class Collapse: ctrlButtonCollapseAll {
            idc = IDC_LM_COLLAPSE;
            x = QUOTE((getResolution select 2) * 0.5 * pixelW + (140/2 - 50 + 10) * GRID_3DEN_W);
            y = QUOTE(0.5 + (120/2 - 10 - 7 - 1) * GRID_3DEN_H);
            w = QUOTE(5 * GRID_3DEN_W);
            h = QUOTE(5 * GRID_3DEN_H);
        };
        class Expand: ctrlButtonExpandAll {
            idc = IDC_LM_EXPAND;
            x = QUOTE((getResolution select 2) * 0.5 * pixelW + (140/2 - 50 + 15) * GRID_3DEN_W);
            y = QUOTE(0.5 + (120/2 - 10 - 7 - 1) * GRID_3DEN_H);
            w = QUOTE(5 * GRID_3DEN_W);
            h = QUOTE(5 * GRID_3DEN_H);
        };
        class WarningLabel: ctrlStructuredText {
            idc = IDC_LM_WARNING;
            x = QUOTE((getResolution select 2) * 0.5 * pixelW - (140/2) * GRID_3DEN_W);
            y = QUOTE(0.5 + (120/2 - 10 - 1) * GRID_3DEN_H);
            w = QUOTE(87 * GRID_3DEN_W);
            h = QUOTE(5 * GRID_3DEN_H);
        };
        class ButtonOK: ctrlButtonOK {
            x = QUOTE((getResolution select 2) * 0.5 * pixelW + (140/2 - 50 - 2) * GRID_3DEN_W);
            y = QUOTE(0.5 + (120/2 - 10 - 1) * GRID_3DEN_H);
            w = QUOTE(25 * GRID_3DEN_W);
            h = QUOTE(5 * GRID_3DEN_H);
        };
        class ButtonCancel: ctrlButtonCancel {
            x = QUOTE((getResolution select 2) * 0.5 * pixelW + (140/2 - 25 - 1) * GRID_3DEN_W);
            y = QUOTE(0.5 + (120/2 - 10 - 1) * GRID_3DEN_H);
            w = QUOTE(25 * GRID_3DEN_W);
            h = QUOTE(5 * GRID_3DEN_H);
        };
    };
};
