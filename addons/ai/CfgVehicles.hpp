class CfgVehicles {
    class B_TargetSoldier;
    class CBA_B_InvisibleTarget: B_TargetSoldier {
        author = "$STR_CBA_Author";
        scope = 2;
        scopeArsenal = 0;
        model = QPATHTOF(InvisibleTarget.p3d);
        icon = "CBA_iconInvisibleTarget";

        class HitPoints {};
    };

    class O_TargetSoldier;
    class CBA_O_InvisibleTarget: O_TargetSoldier {
        author = "$STR_CBA_Author";
        scope = 2;
        scopeArsenal = 0;
        model = QPATHTOF(InvisibleTarget.p3d);
        icon = "CBA_iconInvisibleTarget";

        class HitPoints {};
    };

    class I_TargetSoldier;
    class CBA_I_InvisibleTarget: I_TargetSoldier {
        author = "$STR_CBA_Author";
        scope = 2;
        scopeArsenal = 0;
        model = QPATHTOF(InvisibleTarget.p3d);
        icon = "CBA_iconInvisibleTarget";

        class HitPoints {};
    };

    class Strategic;
    class CBA_BuildingPos: Strategic {
        author = "$STR_CBA_Author";
        scope = 2;
        scopeArsenal = 0;
        displayName = CSTRING(BuildingPos);
        model = QPATHTOF(BuildingPos.p3d);
        icon = "iconObject_circle";
        editorCategory = "EdCat_VRObjects";
        editorSubcategory = "EdSubcat_Helpers";
    };
};
