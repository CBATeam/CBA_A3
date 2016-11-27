#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = CSTRING(component);
        url = "$STR_CBA_URL";
        units[] = {};
        weapons[] = {};
		magazines[] = {};
		ammo[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"A3_Weapons_F","A3_Weapons_F_Mark","A3_Weapons_F_Exp"};
        version = VERSION;
        authors[] = {"Robalo"};
		authorUrl = "http://dev-heaven.net/projects/cca";
    };
};

PRELOAD_ADDONS;

#include "CfgAmmo.hpp"
#include "CfgMagazines.hpp"
#include "CfgWeapons.hpp"
