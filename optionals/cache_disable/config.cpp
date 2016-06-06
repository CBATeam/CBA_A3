#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = ECSTRING(Optional,Component);
        url = "$STR_CBA_URL";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"CBA_Extended_EventHandlers", "CBA_Main"};
        version = VERSION;
        authors[] = {"Sickboy"};
    };
};

class CfgSettings {
    class CBA {
        class Caching {
            xeh = 0;
            compile = 0;
            functions = 0;
        };
    };
};
