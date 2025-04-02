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
        ADDON = QUOTE(call (uiNamespace getVariable 'FUNC(initDisplayInterrupt)'));
    };
    class RscDisplayMPInterrupt {
        ADDON = QUOTE(call (uiNamespace getVariable 'FUNC(initDisplayInterrupt)'));
    };
    class RscDisplayMultiplayerSetup {
        ADDON = QUOTE(call (uiNamespace getVariable 'FUNC(initDisplayMultiplayerSetup)'));
    };
    class RscDisplayOptionsLayout {
        ADDON = QUOTE(call (uiNamespace getVariable 'FUNC(initDisplayOptionsLayout)'));
    };
    class RscDisplayPassword {
        ADDON = QUOTE(call (uiNamespace getVariable 'FUNC(initDisplayPassword)'));
    };
    class RscDisplayRemoteMissions {
        ADDON = QUOTE(call (uiNamespace getVariable 'FUNC(initDisplayRemoteMissions)'));
    };
    class RscDiary {
        ADDON = QUOTE(call (uiNamespace getVariable 'FUNC(initDisplayDiary)'));
    };
    class Display3DEN {
        ADDON = QUOTE(call (uiNamespace getVariable 'FUNC(initDisplay3DEN)'));
    };
    class RscDisplayCurator {
        ADDON = QUOTE(call (uiNamespace getVariable 'FUNC(initDisplayCurator)'));
    };
    class RscMsgBox {
        ADDON = QUOTE(call (uiNamespace getVariable 'FUNC(initDisplayMessageBox)'));
    };
    class RscDisplayInventory {
        ADDON = QUOTE(call (uiNamespace getVariable 'FUNC(initDisplayInventory)'));
    };
};
