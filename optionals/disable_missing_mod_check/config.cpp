#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = ECSTRING(Optional,Component);
        url = "$STR_CBA_URL";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"CBA_extended_eventhandlers", "CBA_versioning"};
        version = VERSION;
        authors[] = {"Dedmen"};
    };
};

CBA_disableMissingModCheck = 1;
