
class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preInit));
    };
};

class Extended_DisplayLoad_EventHandlers {
    class RscDisplayDebugPublic {
        CBA_extendedDebug = QUOTE(_this call COMPILE_FILE(fnc_initExtendedDebug));
        // remove scripted cancel button.
        CBA_removeCancelBtn = "((_this select 0) displayCtrl 2) ctrlEnable false; ((_this select 0) displayCtrl 2) ctrlShow false;";
    };
    class RscDisplayInterrupt {
        CBA_extendedDebug = QUOTE(_this call COMPILE_FILE(fnc_initExtendedDebug));
    };
    class RscDisplayMPInterrupt {
        CBA_extendedDebug = QUOTE(_this call COMPILE_FILE(fnc_initExtendedDebug));
    };
};
