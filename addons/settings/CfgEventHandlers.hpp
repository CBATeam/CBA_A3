
class Extended_PreStart_EventHandlers {
    class ADDON {
        init = QUOTE(if (!IS_LINUX) then {call COMPILE_FILE(XEH_preStart)};);
    };
};

class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(if (!IS_LINUX) then {call COMPILE_FILE(XEH_preInit)};);
    };
};

class Extended_PostInit_EventHandlers {
    class ADDON {
        init = QUOTE(if (!IS_LINUX) then {call COMPILE_FILE(XEH_postInit)};);
    };
};

class Extended_DisplayLoad_EventHandlers {
    class RscDisplayGameOptions {
        ADDON = QUOTE(if (IS_LINUX || {isNil 'ADDON'}) then {_this call COMPILE_FILE(gui_initDisplay_disabled)} else {_this call COMPILE_FILE(gui_initDisplay)};);
    };
    class Display3DEN {
        ADDON = QUOTE(if (!IS_LINUX) then {_this call COMPILE_FILE(init3DEN)};);
    };
};
