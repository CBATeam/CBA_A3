class CfgUIGrids {
    class IGUI {
        class Presets {
            class Arma3 {
                class Variables {
                    GVAR(hints)[] = {
                        {
                            HINT_CONTAINER_X,
                            HINT_CONTAINER_Y,
                            HINT_CONTAINER_W,
                            HINT_CONTAINER_H
                        },
                        5 * GUI_GRID_CENTER_W,
                        5 * GUI_GRID_CENTER_H
                    };
                };
            };
        };

        class Variables {
            class GVAR(hints) {
                displayName = CSTRING(HintsPositionName);
                description = CSTRING(HintsPositionDescription);
                preview = "#(argb,8,8,3)color(0,0,0,0.25)";
                saveToProfile[] = {0,1,2,3};
                canResize = 1;
            };
        };
    };
};
