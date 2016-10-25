
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
    };
};

class Extended_DisplayLoad_EventHandlers {
    class RscDisplayGameOptions {
        ADDON = QUOTE(if (isNil 'ADDON') then {_this call (uiNamespace getVariable 'FUNC(gui_initDisplay_disabled)')} else {_this call (uiNamespace getVariable 'FUNC(gui_initDisplay)')};);
    };
    class Display3DEN {
        ADDON = QUOTE(_this call (uiNamespace getVariable 'FUNC(init3DEN)'));
    };
};
