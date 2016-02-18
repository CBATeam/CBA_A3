
class CfgSettings {
    class CBA {
        class Events {
            class TestAddon {
                action1 = 15; // tab

                class action2 { // ctrl T
                    key = 20;
                    shift = 0;
                    ctrl = 1;
                    alt = 0;
                };
            };
        };
    };
};

/*
a1 = ["TestAddon", "action1", { systemChat str _this }] call CBA_fnc_addKeyHandlerFromConfig;
a2 = ["TestAddon", "action2", { systemChat str _this }] call CBA_fnc_addKeyHandlerFromConfig;
*/
