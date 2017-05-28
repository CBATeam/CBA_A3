#include "script_component.hpp"

// Simply a package which requires other addons.
class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = CSTRING(component);
        url = "$STR_CBA_URL";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        // "CBA_XEH",  would create circular dependency, however XEH is required by CBA common in any case :)
        requiredAddons[] = {"cba_common", "cba_arrays", "cba_hashes", "cba_strings", "cba_events", "cba_diagnostic", "cba_network", "cba_ai", "cba_vectors", "cba_ui", "cba_ui_helper", "cba_help"};
        versionDesc = "C.B.A.";
        VERSION_CONFIG;
        authors[] = {};
    };
};

/*
class CfgMods {
    class PREFIX {
        dir = "@CBA";
        name = "Community Base Addons";
        picture = "x\cba\addons\main\logo_cba_ca.paa";
        hidePicture = "true";
        hideName = "true";
        actionName = "Website";
        action = "http://dev-heaven.net/projects/cca";
        description = "Bugtracker: http://dev-heaven.net/projects/cca<br />Documentation: http://dev-heaven.net/projects/cca";
    };
};
*/
class CfgSettings {
    class CBA {
        class Caching {
            functions = 1;
        };
        class Versioning {
            class PREFIX {
                class dependencies {
                    /*
                        // CBA requiring CBA_A2, if A2 is found
                        CBA_A2[] = {"cba_a2_main", {1,0,0}, "isClass(configFile >> 'CfgPatches' >> 'Chernarus')"};
                        // CBA requiring CBA_OA, if OA is found
                        CBA_OA[] = {"cba_oa_main", {1,0,0}, "isClass(configFile >> 'CfgPatches' >> 'Takistan')"};
                        // CBA requiring CBA_TOH, if TOH is found
                        CBA_TOH[] = {"cba_toh_main", {1,0,0}, "isClass(configFile >> 'CfgPatches' >> 'United_States_H')"};
                    */
                    // CBA requiring CBA_A3, if A3 is found
                    CBA_A3[] = {"cba_main_a3", {1,0,0}, "isClass(configFile >> 'CfgPatches' >> 'A3_Map_Stratis')"};

                    XEH[] = {"cba_xeh", {1,0,0}, "(true)"};
                };
            };
        };
        class Registry {
            class PREFIX {
                removed[] = {"cba_linux","cba_static_settings_addon","cba_auto_load_settings_file"};
            };
        };
    };
};

#include "CfgVehicles.hpp"

scriptsPath = QPATHTO_R(Scripts\);
