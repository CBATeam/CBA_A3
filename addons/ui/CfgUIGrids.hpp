class CfgUIGrids {
    class IGUI {
        class Presets {
            class Arma3 {
                class Variables {
                    GVAR(grid)[] = {
                        {
                            1 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X,
                            0 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y,
                            38 * GUI_GRID_CENTER_W,
                            1 * GUI_GRID_CENTER_H
                        },
                        0.5 * GUI_GRID_CENTER_W,
                        0.5 * GUI_GRID_CENTER_H
                    };

                    GVAR(notify)[] = {
                        {
                            safezoneX + safezoneW - 16 * GUI_GRID_W,
                            safeZoneY + 6 * GUI_GRID_H,
                            15 * GUI_GRID_W,
                            3 * GUI_GRID_H
                        },
                        GUI_GRID_W,
                        GUI_GRID_H
                    };
                };
            };
        };

        class Variables {
            class GVAR(grid) {
                displayName = CSTRING(ProgressBarPositionName);
                description = CSTRING(ProgressBarPositionDescription);
                preview = "#(argb,8,8,3)color(0,0,0,0.5)";
                saveToProfile[] = {0,1,2,3};
                canResize = 1;
            };

            class GVAR(notify) {
                displayName = "CBA Notify";
                description = "Textual in game feedback to the player.";
                preview = "#(argb,8,8,3)color(0,0,0,0.5)";
                saveToProfile[] = {0,1};
            };
        };
    };
};
