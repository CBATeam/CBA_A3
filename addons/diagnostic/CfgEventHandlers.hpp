
class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preInit));
    };
};

class Extended_DisplayLoad_EventHandlers {
    class RscDisplayDebugPublic {
        CBA_showDebugConsole = QUOTE(call COMPILE_FILE(fnc_initExtendedDebug));
    };
    class RscDisplayInterrupt {
        CBA_showDebugConsole = QUOTE(call COMPILE_FILE(fnc_initExtendedDebug));
    };
    class RscDisplayMPInterrupt {
        CBA_showDebugConsole = QUOTE(call COMPILE_FILE(fnc_initExtendedDebug));
    };
};
