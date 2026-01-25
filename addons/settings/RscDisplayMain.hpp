class RscStandardDisplay;
class RscDisplayMain: RscStandardDisplay {
    class controls {
        class GroupSingleplayer: RscControlsGroupNoScrollbars {
            class Controls {
                class Campaigns;
            };
        };

        class GroupOptions: GroupSingleplayer {
            h = "(6 *   1.5) *  (pixelH * pixelGrid * 2)";

            class Controls: Controls {
                class GVAR(AddonOptions): Campaigns {
                    idc = IDC_MAIN_ADDONOPTIONS;
                    text = CSTRING(menu_button);
                    tooltip = CSTRING(menu_button_tooltip);
                    y = "(4 *   1.5) *  (pixelH * pixelGrid * 2) +  (pixelH)";
                    onbuttonclick = QUOTE(ctrlParent (_this select 0) call FUNC(openSettingsMenu));
                };
                class Expansions: Campaigns {
                    y = "(5 *   1.5) *  (pixelH * pixelGrid * 2) +  (pixelH)";
                };
            };
        };
    };
};
