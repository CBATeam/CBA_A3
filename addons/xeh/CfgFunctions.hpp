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
                file = QPATHTOF(fnc_preStart.sqf);
            };
            class preInit {
                preInit = 1;
                file = QPATHTOF(fnc_preInit.sqf);
            };
            class postInit {
                postInit = 1;
                file = QPATHTOF(fnc_postInit.sqf);
            };
        };
    };

    class A3 {
        class GUI {
            class initDisplay {
                file = QPATHTOF(fnc_initDisplay.inc.sqf);
            };
        };
        class Misc {
            class startLoadingScreen {
                file = QPATHTOF(fnc_startLoadingScreen.inc.sqf);
            };
            class endLoadingScreen {
                file = QPATHTOF(fnc_endLoadingScreen.inc.sqf);
            };
        };
    };
};
