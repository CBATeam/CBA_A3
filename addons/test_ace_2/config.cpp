
class CfgPatches {
    class ACE_Dummy {
        units[] = {};
        weapons[] = {};
        requiredVersion = 0.1;
        requiredAddons[] = {"CBA_Dummy"};
        versionAr[] = {2,0,0};

        versionDependencies[] = {
            {"CBA_Dummy", {2,0,0}, "true"}
        };
    };
};
