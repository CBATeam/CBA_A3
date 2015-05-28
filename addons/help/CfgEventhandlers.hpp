class Extended_PreInit_EventHandlers {
    class ADDON {
        clientInit = QUOTE(call COMPILE_FILE(XEH_preClientInit));
    };
};

class Extended_PostInit_EventHandlers {
    class ADDON {
        clientInit = QUOTE(call COMPILE_FILE(XEH_postClientInit));
    };
};

class CBA_MouseTrapEvent {
    class IDC_2222711 { //CBA_CREDITS_M_IDC
        cba_ver_line = "\x\cba\addons\help\ver_line.sqf";
    };
    class IDC_2222714 { //CBA_CREDITS_M_P_IDC
        cba_cred_line = "\x\cba\addons\help\cred_line.sqf";
    };
};
