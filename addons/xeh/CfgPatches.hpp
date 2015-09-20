class CfgPatches {
    class ADDON {
        units[] = {};
        weapons[] = {};
        worlds[] = {};
        requiredAddons[] = {"A3_Data_F","A3_Air_F","A3_Air_F_Beta"};
        requiredVersion = REQUIRED_VERSION;
        VERSION_CONFIG;
        author[] = {"CBA Team", "Solus", "Killswitch"};
        authorUrl = "https://github.com/CBATeam/CBA_A3";
    };

    // Backwards compatibility
    class Extended_EventHandlers {
        units[] = {};
        weapons[] = {};
        worlds[] = {};
        requiredAddons[] = {"A3_Data_F","A3_Air_F","A3_Air_F_Beta"};
        requiredVersion = REQUIRED_VERSION;
        version = "4.0.0"; // Due to older mod versions requiring > 3,3,3 etc
        versionStr = "4.0.0";
        versionAr[] = {4,0,0};
        author[] = {"CBA Team", "Solus", "Killswitch"};
        authorUrl = "https://github.com/CBATeam/CBA_A3";
    };

    class CBA_Extended_EventHandlers {
        units[] = {};
        weapons[] = {};
        worlds[] = {};
        requiredAddons[] = {"A3_Data_F","A3_Air_F","A3_Air_F_Beta"};
        requiredVersion = REQUIRED_VERSION;
        VERSION_CONFIG;
        author[] = {"CBA Team", "Solus", "Killswitch"};
        authorUrl = "https://github.com/CBATeam/CBA_A3";
    };
};
