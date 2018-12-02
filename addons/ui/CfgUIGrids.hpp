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
                            NOTIFY_DEFAULT_X,
                            NOTIFY_DEFAULT_Y,
                            NOTIFY_MIN_WIDTH,
                            NOTIFY_MIN_HEIGHT
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
                preview = "#(argb,8,8,3)color(0,0,0,0.25)";
                saveToProfile[] = {0,1,2,3};
                canResize = 1;
            };

            class GVAR(notify) {
                displayName = CSTRING(NotificationPositionName);
                description = CSTRING(NotificationPositionDescription);
                preview = "#(argb,8,8,3)color(0,0,0,0.25)";
                saveToProfile[] = {0,1};
            };
        };
    };
};
