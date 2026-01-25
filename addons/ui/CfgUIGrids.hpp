class CfgUIGrids {
    class IGUI {
        class Presets {
            class Arma3 {
                class Variables {
                    GVAR(grid)[] = {
                        {
                            QUOTE(1 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X),
                            QUOTE(0 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y),
                            QUOTE(38 * GUI_GRID_CENTER_W),
                            QUOTE(1 * GUI_GRID_CENTER_H)
                        },
                        QUOTE(0.5 * GUI_GRID_CENTER_W),
                        QUOTE(0.5 * GUI_GRID_CENTER_H)
                    };

                    GVAR(notify)[] = {
                        {
                            QUOTE(NOTIFY_DEFAULT_X),
                            QUOTE(NOTIFY_DEFAULT_Y),
                            QUOTE(NOTIFY_MIN_WIDTH),
                            QUOTE(NOTIFY_MIN_HEIGHT)
                        },
                        QUOTE(GUI_GRID_W),
                        QUOTE(GUI_GRID_H)
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
