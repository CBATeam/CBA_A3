#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = ECSTRING(Optional,Component);
        url = "$STR_CBA_URL";
        units[] = {};
        requiredVersion = 1.02;
        requiredAddons[] = {"CBA_common","CBA_diagnostic"};
        version = "0.4.1.101";
        authors[] = {"Spooner","Sickboy"};
    };
};

class Extended_PostInit_EventHandlers {
    class ADDON {
        init = "[] spawn cba_diagnostic_fnc_perf_loop";
    };
};
