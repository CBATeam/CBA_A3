class Extended_PreStart_EventHandlers {
    class ADDON {
        init = QUOTE(if (!IS_LINUX) then {call COMPILE_FILE(XEH_preStart)});
    };
};

class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(if (!IS_LINUX) then {call COMPILE_FILE(XEH_preInit)});
    };
};
