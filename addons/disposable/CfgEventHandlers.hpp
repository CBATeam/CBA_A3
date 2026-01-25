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
    class RscDisplayInventory {
        ADDON = QUOTE(call (uiNamespace getVariable 'FUNC(initDisplayInventory)'));
    };
};
