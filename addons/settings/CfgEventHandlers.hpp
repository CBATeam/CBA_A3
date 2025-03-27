class Extended_PreStart_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_SCRIPT(XEH_preStart));
    };
};

class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_SCRIPT(XEH_preInit));
    };
};

class Extended_PostInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_SCRIPT(XEH_postInit));
    };
};

class Extended_DisplayLoad_EventHandlers {
    class RscDisplayMain {
        ADDON = QUOTE(call (uiNamespace getVariable 'FUNC(initDisplayMain)'));
    };
    class RscDisplayGameOptions {
        ADDON = QUOTE(call (uiNamespace getVariable 'FUNC(initDisplayGameOptions)'));
    };
    class Display3DEN {
        ADDON = QUOTE(call (uiNamespace getVariable 'FUNC(initDisplay3DEN)'));
    };
};
