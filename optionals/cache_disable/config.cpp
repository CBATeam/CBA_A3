#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"CBA_Extended_EventHandlers", "CBA_Main"};
        version = VERSION;
        author = "$STR_CBA_Author";
        authors[] = {"Sickboy"};
        authorUrl = "http://dev-heaven.net/projects/cca";
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
