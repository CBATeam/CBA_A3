#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "CBA_Main"
        };
        VERSION_CONFIG;
        author[] = {"CBA Team"};
        authorUrl = "https://github.com/CBATeam/CBA_A3";
    };
};

class CfgSettings {
    class CBA {
        class Versioning {
            class PREFIX {
                class Dependencies {
                    CBA[] = {"cba_main", { 1,0,0 },"true"};
                };
            };
        };
    };
};

class CfgMods {
    class PREFIX {
        dir = "@CBA_A3";
        name = "Community Base Addons (Arma III)";
        picture = "x\cba\addons\main\logo_cba_ca.paa";
        hidePicture = "true";
        hideName = "true";
        actionName = "Website";
        action = "http://dev-heaven.net/projects/cca";
    };
};
