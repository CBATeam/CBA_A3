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

class Extended_PostInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_SCRIPT(XEH_postInit));
    };
};

class Extended_DisplayLoad_EventHandlers {
    class RscDisplayMission {
        ADDON = QUOTE(call (uiNamespace getVariable 'FUNC(initDisplayMission)'));
    };
    class RscDiary {
        ADDON = QUOTE(if (ctrlIDD (_this select 0) == 12) then {_this call (uiNamespace getVariable 'FUNC(initDisplayMainMap)')};);
    };
    class RscDisplayCurator {
        ADDON = QUOTE(call (uiNamespace getVariable 'FUNC(initDisplayCurator)'));
    };
};
