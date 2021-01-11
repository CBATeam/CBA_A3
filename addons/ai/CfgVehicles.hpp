class CfgVehicles {
    class B_TargetSoldier;
    class CBA_B_InvisibleTarget: B_TargetSoldier {
        author = "$STR_CBA_Author";
        displayName = CSTRING(InvisibleTargetSoldier);
        scope = 2;
        scopeCurator = 2;
        scopeArsenal = 0;
        model = QPATHTOF(InvisibleTarget.p3d);
        icon = "CBA_iconInvisibleTarget";

        class HitPoints {};
    };

    class O_TargetSoldier;
    class CBA_O_InvisibleTarget: O_TargetSoldier {
        author = "$STR_CBA_Author";
        displayName = CSTRING(InvisibleTargetSoldier);
        scope = 2;
        scopeCurator = 2;
        scopeArsenal = 0;
        model = QPATHTOF(InvisibleTarget.p3d);
        icon = "CBA_iconInvisibleTarget";

        class HitPoints {};
    };

    class I_TargetSoldier;
    class CBA_I_InvisibleTarget: I_TargetSoldier {
        author = "$STR_CBA_Author";
        displayName = CSTRING(InvisibleTargetSoldier);
        scope = 2;
        scopeCurator = 2;
        scopeArsenal = 0;
        model = QPATHTOF(InvisibleTarget.p3d);
        icon = "CBA_iconInvisibleTarget";

        class HitPoints {};
    };

    class CBA_B_InvisibleTargetVehicle: CBA_B_InvisibleTarget {
        author = "$STR_CBA_Author";
        displayName = CSTRING(InvisibleTargetVehicle);
        model = QPATHTOF(InvisibleTargetVehicle.p3d);
        crewVulnerable = 0;
        type = 1;
        cost = 1000000;
    };

    class CBA_O_InvisibleTargetVehicle: CBA_O_InvisibleTarget {
        author = "$STR_CBA_Author";
        displayName = CSTRING(InvisibleTargetVehicle);
        model = QPATHTOF(InvisibleTargetVehicle.p3d);
        crewVulnerable = 0;
        type = 1;
        cost = 1000000;
    };

    class CBA_I_InvisibleTargetVehicle: CBA_I_InvisibleTarget {
        author = "$STR_CBA_Author";
        displayName = CSTRING(InvisibleTargetVehicle);
        model = QPATHTOF(InvisibleTargetVehicle.p3d);
        crewVulnerable = 0;
        type = 1;
        cost = 1000000;
    };

    class CBA_B_InvisibleTargetAir: CBA_B_InvisibleTargetVehicle {
        author = "$STR_CBA_Author";
        displayName = CSTRING(InvisibleTargetAir);
        type = 2;
        cost = 10000000;
    };

    class CBA_O_InvisibleTargetAir: CBA_O_InvisibleTargetVehicle {
        author = "$STR_CBA_Author";
        displayName = CSTRING(InvisibleTargetAir);
        type = 2;
        cost = 10000000;
    };

    class CBA_I_InvisibleTargetAir: CBA_I_InvisibleTargetVehicle {
        author = "$STR_CBA_Author";
        displayName = CSTRING(InvisibleTargetAir);
        type = 2;
        cost = 10000000;
    };

    class Strategic;
    class CBA_BuildingPos: Strategic {
        author = "$STR_CBA_Author";
        scope = 2;
        scopeCurator = 2;
        scopeArsenal = 0;
        displayName = CSTRING(BuildingPos);
        model = QPATHTOF(BuildingPos.p3d);
        icon = "iconObject_circle";
        editorCategory = "EdCat_VRObjects";
        editorSubcategory = "EdSubcat_Helpers";
    };
};
