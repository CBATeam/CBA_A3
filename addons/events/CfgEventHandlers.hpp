
class Extended_PreStart_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preStart));
    };
};

class Extended_PreInit_EventHandlers
{
    class ADDON
    {
        init = QUOTE(call COMPILE_FILE(XEH_preInit));
        clientInit = QUOTE(call COMPILE_FILE(XEH_preClientInit));
    };
};

/*
class Extended_Hit_EventHandlers
{
    class All
    {
        GVAR(hit) = QUOTE(_this call FUNC(globalHitEvent));
    };
};

class Extended_Killed_EventHandlers
{
    class All
    {
        GVAR(killed) = QUOTE(_this call FUNC(globalKilledEvent));
    };
};
*/