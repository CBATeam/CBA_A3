#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = ECSTRING(Optional,Component);
        url = "$STR_CBA_URL";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"CBA_Diagnostic"};
        version = VERSION;
        authors[] = {"Sickboy"};
    };
};

class Extended_Init_EventHandlers {
    class All {
        class cba_diagnostic_logging {
            init = "diag_log [diag_frameNo, diag_fps, diag_tickTime, time, _this, typeOf (_this select 0), getPosASL (_this select 0)]";
        };
    };
};
