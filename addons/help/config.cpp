#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = CSTRING(component);
        url = "$STR_CBA_URL";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_common","cba_hashes","cba_keybinding","A3_UI_F"};
        version = VERSION;
        authors[] = {"alef","Rocko","Sickboy"};
    };
};

#include "CfgEventhandlers.hpp"

#include "gui.hpp"
