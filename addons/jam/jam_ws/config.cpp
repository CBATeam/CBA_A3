#if __has_include("\lxWS\data_f_lxWS\config.bin")

#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = ECSTRING(jam,component);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
        	"cba_jam",
        	"Weapons_F_lxWS_Rifles"
        };
        author = "$STR_CBA_Author";
        authors[] = {};
        url = "$STR_CBA_URL";
        VERSION_CONFIG;
    };
};

#include "CfgWeapons.hpp"

#endif
