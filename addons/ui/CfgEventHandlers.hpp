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

class Extended_DisplayLoad_EventHandlers {
    class RscDisplayInterrupt {
        ADDON = QUOTE(_this call (uiNamespace getVariable 'FUNC(initDisplayInterrupt)'));
    };
    class RscDisplayMPInterrupt {
        ADDON = QUOTE(_this call (uiNamespace getVariable 'FUNC(initDisplayInterrupt)'));
    };
    class RscDisplayMultiplayerSetup {
        ADDON = QUOTE(_this call (uiNamespace getVariable 'FUNC(initDisplayMultiplayerSetup)'));
    };
    class RscDisplayOptionsLayout {
        ADDON = QUOTE(_this call (uiNamespace getVariable 'FUNC(initDisplayOptionsLayout)'));
    };
    class RscDisplayPassword {
        ADDON = QUOTE(_this call (uiNamespace getVariable 'FUNC(initDisplayPassword)'));
    };
    class RscDisplayRemoteMissions {
        ADDON = QUOTE(_this call (uiNamespace getVariable 'FUNC(initDisplayRemoteMissions)'));
    };
    class RscDiary {
        ADDON = QUOTE(_this call (uiNamespace getVariable 'FUNC(initDisplayDiary)'));
    };
    class Display3DEN {
        ADDON = QUOTE(_this call (uiNamespace getVariable 'FUNC(initDisplay3DEN)'));
    };
    class RscDisplayCurator {
        ADDON = QUOTE(_this call (uiNamespace getVariable 'FUNC(initDisplayCurator)'));
    };
    class RscMsgBox {
        ADDON = QUOTE(_this call (uiNamespace getVariable 'FUNC(initDisplayMessageBox)'));
    };
    class RscDisplayInventory {
        ADDON = QUOTE(_this call (missionNamespace getVariable 'FUNC(initDisplayInventory)'));
    };
};
