class CfgFunctions {
    init = QPATHTO_R(XEH_initFunctions.sqf);

    class CBA {
        class XEH {
            class preStart {
                preStart = 1;
                file = PATHTOF(fnc_preStart.sqf);
            };
            class preInit {
                preInit = 1;
                file = PATHTOF(fnc_preInit.sqf);
            };
            class postInit {
                postInit = 1;
                file = PATHTOF(fnc_postInit.sqf);
            };
        };
    };

    class A3 {
        class GUI {
            class initDisplay {
                file = PATHTOF(fnc_initDisplay.sqf);
            };
        };
        class Misc {
            class startLoadingScreen {
                file = PATHTOF(fnc_startLoadingScreen.sqf);
            };
            class endLoadingScreen {
                file = PATHTOF(fnc_endLoadingScreen.sqf);
            };
        };
    };
};
