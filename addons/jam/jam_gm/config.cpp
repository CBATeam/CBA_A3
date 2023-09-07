#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = ECSTRING(jam,component);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "cba_jam",
            "gm_weapons_launchers_carlgustaf",
            "gm_weapons_launchers_rpg7",
            "gm_weapons_machineguns_mg3",
            "gm_weapons_machineguns_pk",
            "gm_weapons_machinepistols_gm_mp2",
            "gm_weapons_machinepistols_gm_pm63",
            "gm_weapons_pistols_p1",
            "gm_weapons_pistols_pm",
            "gm_weapons_rifles_ak47",
            "gm_weapons_rifles_ak74",
            "gm_weapons_rifles_g3",
            "gm_weapons_rifles_g36",
            "gm_weapons_rifles_m16",
            "gm_weapons_rifles_mp5",
            "gm_weapons_rifles_svd"
        };
        author = "$STR_CBA_Author";
        authors[] = {};
        url = "$STR_CBA_URL";
        skipWhenMissingDependencies = 1;
        VERSION_CONFIG;
    };
};

#include "CfgMagazineWells.hpp"
#include "CfgWeapons.hpp"
