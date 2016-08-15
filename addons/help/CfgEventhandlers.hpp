
class Extended_PreStart_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preStart));
    };
};

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
        CBA_helpVersion = QUOTE(_this call (uiNamespace getVariable 'FUNC(setVersionLine)'));
        CBA_helpCredits = QUOTE(_this call (uiNamespace getVariable 'FUNC(setCreditsLine)'));
    };
    class RscDisplayInterrupt {
        CBA_helpVersion = QUOTE(_this call (uiNamespace getVariable 'FUNC(setVersionLine)'));
        CBA_helpCredits = QUOTE(_this call (uiNamespace getVariable 'FUNC(setCreditsLine)'));
    };
    class RscDisplayMPInterrupt {
        CBA_helpVersion = QUOTE(_this call (uiNamespace getVariable 'FUNC(setVersionLine)'));
        CBA_helpCredits = QUOTE(_this call (uiNamespace getVariable 'FUNC(setCreditsLine)'));
    };
};
