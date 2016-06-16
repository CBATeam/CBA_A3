
class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preInit));
    };
};

class Extended_DisplayLoad_EventHandlers {
    class RscDisplayConfigure {
        ADDON = QUOTE(_this call COMPILE_FILE(XEH_configureDisplayLoad));
    };
};
