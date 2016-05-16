
#define COMPILE_EFILE(comp,var1) COMPILE_FILE_SYS(PREFIX,comp,var1)

class Extended_PreStart_EventHandlers {
    class DOUBLES(PREFIX,events) {
        init = QUOTE(call COMPILE_EFILE(events,XEH_preStart));
    };
};

class Extended_PreInit_EventHandlers {
    class DOUBLES(PREFIX,common) {
        init = QUOTE(call COMPILE_EFILE(common,XEH_preInit));
    };
    class DOUBLES(PREFIX,events) {
        init = QUOTE(call COMPILE_EFILE(events,XEH_preInit));
    };
};
