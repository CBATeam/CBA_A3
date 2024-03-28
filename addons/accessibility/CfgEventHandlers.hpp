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

class Extended_SoundPlayed_EventHandlers {
    class CAManBase {
        class ADDON {
            soundPlayed = QUOTE(_this call FUNC(vanillaSoundPlayed));
        };
    };
};

class Extended_DisplayLoad_EventHandlers {
    class RscDisplayMission {
        ADDON = QUOTE([] call FUNC(createHintDisplay));
    };
};
