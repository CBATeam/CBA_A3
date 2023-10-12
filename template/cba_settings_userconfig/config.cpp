
class CfgPatches {
    class cba_settings_userconfig {
        author = "$STR_CBA_Author";
        name = "$STR_CBA_Settings_Component";
        url = "$STR_CBA_URL";
        units[] = {};
        weapons[] = {};
        requiredVersion = 1.0;
        requiredAddons[] = {"cba_settings"};
        version = 1.0;
        authors[] = {"commy2"};
    };
};

// Uncommenting this will make any changes to "Server" settings be lost upon game restart
// cba_settings_volatile = 1;
