
class Extended_PreStart_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preStart));
    };
};

class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preInit));
    };
};

class Extended_PostInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_postInit));
    };
};

class Extended_DisplayLoad_EventHandlers {
    class RscDisplayMain {
        ADDON = QUOTE(_this call (uiNamespace getVariable 'FUNC(initDisplayMain)'));
    };
    class RscDisplayGameOptions {
        ADDON = QUOTE(_this call (uiNamespace getVariable 'FUNC(initDisplayGameOptions)'));
    };
    class Display3DEN {
        ADDON = QUOTE(_this call (uiNamespace getVariable 'FUNC(initDisplay3DEN)'));
    };
};
