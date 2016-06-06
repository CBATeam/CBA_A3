
#define F_FILEPATH_XEH(comp,func) class DOUBLES(PREFIX,comp) {\
    init = __EVAL([QUOTE(call COMPILE_FILE_SYS(PREFIX,comp,func)), QUOTE(call COMPILE_FILE_SYS(PREFIX,comp,DOUBLES(func,Linux)))] select IS_LINUX);\
}

class Extended_PreStart_EventHandlers {
    F_FILEPATH_XEH(events,XEH_preStart);
};

class Extended_PreInit_EventHandlers {
    F_FILEPATH_XEH(common,XEH_preInit);
    F_FILEPATH_XEH(events,XEH_preInit);
};
