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

class Extended_DisplayLoad_EventHandlers {
    class RscDisplayInterrupt {
        ADDON = QUOTE(_this call (uiNamespace getVariable 'FUNC(initDisplayInterrupt)'));
    };
    class RscDisplayMPInterrupt {
        ADDON = QUOTE(_this call (uiNamespace getVariable 'FUNC(initDisplayInterrupt)'));
    };
};
