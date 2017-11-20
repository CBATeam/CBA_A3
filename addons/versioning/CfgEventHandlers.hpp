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
        clientInit = QUOTE(if !(isServer) then {call COMPILE_FILE(XEH_postInitClient)});
    };
};
