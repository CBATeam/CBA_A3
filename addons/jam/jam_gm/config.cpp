#if __has_include("\gm\gm_core\config.bin")

#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = ECSTRING(jam,component);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_jam"};
        author = "$STR_CBA_Author";
        authors[] = {};
        url = "$STR_CBA_URL";
        VERSION_CONFIG;
    };
};

#include "CfgWeapons.hpp"

#endif
