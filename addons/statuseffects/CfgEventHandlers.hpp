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

class Extended_Engine_EventHandlers {
    class All {
        ADDON = QUOTE(call FUNC(handleEngine));
    };
};
class Extended_Respawn_EventHandlers {
    class All {
        class GVAR(statusEffect) {
            respawn = QUOTE(call FUNC(respawnEH));
        };
    };
};

class Extended_Local_EventHandlers {
    class All {
        class GVAR(statusEffect) {
            local = QUOTE(call FUNC(localEH));
        };
    };
};
