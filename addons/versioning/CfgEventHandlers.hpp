
class Extended_DisplayLoad_EventHandlers {
    class RscDisplayMain {
        ADDON = QUOTE(call COMPILE_FILE(XEH_mainDisplayLoad));
    };
};

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
        serverInit = QUOTE(call COMPILE_FILE(XEH_postInitServer));
        clientInit = QUOTE(call COMPILE_FILE(XEH_postInitClient));
    };
};
