
class Extended_PreInit_EventHandlers {
    class ADDON {
        clientInit = QUOTE(call COMPILE_FILE(XEH_preClientInit));
    };
};

class Extended_PostInit_EventHandlers {
    class ADDON {
        clientInit = QUOTE(call COMPILE_FILE(XEH_postClientInit));
    };
};

class Extended_DisplayLoad_EventHandlers {
    class RscDisplayMain {
        CBA_helpVersion = QUOTE(_this call COMPILE_FILE(ver_line));
        CBA_helpCredits = QUOTE(_this call COMPILE_FILE(cred_line));
    };
    class RscDisplayInterrupt {
        CBA_helpVersion = QUOTE(_this call COMPILE_FILE(ver_line));
        CBA_helpCredits = QUOTE(_this call COMPILE_FILE(cred_line));
    };
    class RscDisplayMPInterrupt {
        CBA_helpVersion = QUOTE(_this call COMPILE_FILE(ver_line));
        CBA_helpCredits = QUOTE(_this call COMPILE_FILE(cred_line));
    };
};
