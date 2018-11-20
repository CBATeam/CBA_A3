class CfgVehicles {
    class B_TargetSoldier;
    class CBA_B_InvisibleTarget: B_TargetSoldier {
        scope = 2;
        model = QPATHTOF(InvisibleTarget.p3d);
        icon = "CBA_iconInvisibleTarget";

        class HitPoints {};
    };

    class O_TargetSoldier;
    class CBA_O_InvisibleTarget: O_TargetSoldier {
        scope = 2;
        model = QPATHTOF(InvisibleTarget.p3d);
        icon = "CBA_iconInvisibleTarget";

        class HitPoints {};
    };

    class I_TargetSoldier;
    class CBA_I_InvisibleTarget: I_TargetSoldier {
        scope = 2;
        model = QPATHTOF(InvisibleTarget.p3d);
        icon = "CBA_iconInvisibleTarget";

        class HitPoints {};
    };
};
