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
    class RscDisplayDebugPublic {
        GVAR(extendedDebug) = QUOTE(call (uiNamespace getVariable 'FUNC(initExtendedDebugConsole)'));
        // remove scripted cancel button.
        GVAR(removeCancelButton) = "((_this select 0) displayCtrl 2) ctrlEnable false; ((_this select 0) displayCtrl 2) ctrlShow false;";
    };
    class RscDisplayInterrupt {
        GVAR(extendedDebug) = QUOTE(call (uiNamespace getVariable 'FUNC(initExtendedDebugConsole)'));
        GVAR(targetDebug) = QUOTE(call (uiNamespace getVariable 'FUNC(initTargetDebugConsole)'));
        GVAR(watchInput) = QUOTE([ARR_2('start',[])] call (uiNamespace getVariable 'FUNC(watchInput)'));
    };
    class RscDisplayMPInterrupt {
        GVAR(extendedDebug) = QUOTE(call (uiNamespace getVariable 'FUNC(initExtendedDebugConsole)'));
        GVAR(targetDebug) = QUOTE(call (uiNamespace getVariable 'FUNC(initTargetDebugConsole)'));
        GVAR(watchInput) = QUOTE([ARR_2('start',[])] call (uiNamespace getVariable 'FUNC(watchInput)'));
    };
};
