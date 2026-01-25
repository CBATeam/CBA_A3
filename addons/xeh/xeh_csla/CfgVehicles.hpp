#define XEH_ENABLED_INHERIT class EventHandlers: EventHandlers {class XEH_CLASS: XEH_CLASS_BASE {};}; SLX_XEH_DISABLED = 0
class CfgVehicles {
    class StaticATWeapon;
    class CSLA_9K113_Stat: StaticATWeapon {
        XEH_ENABLED;
    };

    class Mortar_01_base_F;
    class CSLA_M52_Stat: Mortar_01_base_F {
        XEH_ENABLED;
    };

    class PlaneWreck;
    class CSLA_CIV_AN2_wreck: PlaneWreck {
        XEH_ENABLED;
    };

    class Plane_Base_F;
    class CSLA_Plane_base_F: Plane_Base_F {};
    class CSLA_CIV_Plane_base_F: CSLA_Plane_base_F {
        class EventHandlers;
    };
    class CSLA_CIV_Plane_base: CSLA_CIV_Plane_base_F {
        XEH_ENABLED_INHERIT;
    };

    class StaticMGWeapon;
    class CSLA_UK59L_Stat: StaticMGWeapon {
        XEH_ENABLED;
    };
    class CSLA_UK59T_Stat: StaticMGWeapon {
        XEH_ENABLED;
    };

    class CSLA_DShKM_h_Stat: StaticMGWeapon {
        XEH_ENABLED;
    };

    class CSLA_AGS17_Stat: StaticMGWeapon {
        XEH_ENABLED;
    };

    class US85_M60_Stat: StaticMGWeapon {
        XEH_ENABLED;
    };

    class US85_M2l: StaticMGWeapon {
        XEH_ENABLED;
    };

    class US85_Mk19_stat: StaticMGWeapon {
        XEH_ENABLED;
    };

    class US85_M252_Stat: Mortar_01_base_F {
        XEH_ENABLED;
    };

    class HelicopterWreck;
    class CSLA_Mi24_wreck: HelicopterWreck {
        XEH_ENABLED;
    };
};
