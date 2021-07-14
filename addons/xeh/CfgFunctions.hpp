class CfgFunctions {
    class CBA {
        class XEH {
            PATHTO_FNC(isScheduled);
            PATHTO_FNC(isRecompileEnabled);
            PATHTO_FNC(addClassEventHandler);
            PATHTO_FNC(init);
            PATHTO_FNC(initEvents);
            PATHTO_FNC(supportMonitor);
            PATHTO_FNC(compileEventHandlers);
            PATHTO_FNC(compileFunction);
            PATHTO_FNC(startFallbackLoop);

            class preStart {
                preStart = 1;
                file = PATHTOF(fnc_preStart.sqf);
            };
            class preInit {
                preInit = 1;
                file = PATHTOF(fnc_preInit.sqf);
                // This file cannot be recompiled or it will be undefined at preInit
            };
            class postInit {
                postInit = 1;
                file = PATHTOF(fnc_postInit.sqf);
                RECOMPILE;
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
