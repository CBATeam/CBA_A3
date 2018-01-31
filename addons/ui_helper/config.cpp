#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = ECSTRING(ui,component);
        url = "$STR_CBA_URL";
        units[] = {};
        weapons[] = {};
        worlds[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"CBA_common", "A3_UI_F"};
    };
};
