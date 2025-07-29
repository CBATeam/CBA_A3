class Components: Components {
    class TransportPylonsComponent {
        uiPicture = "";
        class Pylons {
            class Pylon1 {
                hardpoints[] = {ALL_HARDPOINTS};
                attachment = "";
                priority = 5;
                turret[] = {0};
                maxweight = 10000;
                UIposition[] = {0.35, 0.20};
            };
        };
        class Presets {
            class Empty {
                displayName = "Empty";
                attachment[] = {};
            };
        };
    };
};
