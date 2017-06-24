
class CfgVehicles {
    class All {
        XEH_ENABLED;
    };
    class LaserTarget: All {
        XEH_DISABLED;
    };
    class NVTarget: All {
        XEH_DISABLED;
    };
    class ArtilleryTarget: All {
        XEH_DISABLED;
    };
    class FireSectorTarget: All {
        XEH_DISABLED;
    };
    class Static: All {
        XEH_DISABLED;
    };

    class Logic;
    class Module_F: Logic {
        XEH_ENABLED;
    };
    class BIS_Effect_FilmGrain: Module_F {
        XEH_ENABLED;
    };
    class BIS_Effect_Day: BIS_Effect_FilmGrain {
        XEH_ENABLED;
    };
    class BIS_Effect_MovieNight: BIS_Effect_FilmGrain {
        XEH_ENABLED;
    };
    class BIS_Effect_Sepia: BIS_Effect_FilmGrain {
        XEH_ENABLED;
    };

    class HighCommand: Module_F {
        XEH_ENABLED;
    };
    class HighCommandSubordinate: HighCommand {
        XEH_ENABLED;
    };

    class MartaManager: Module_F {
        XEH_ENABLED;
    };

    class Site_F: Module_F {
        XEH_ENABLED;
    };

    class Items_base_F;
    class Skeet_Clay_F: Items_base_F {
        XEH_ENABLED;
    };

    class Thing;
    class test_EmptyObjectForBubbles: Thing {
        XEH_ENABLED;
    };
    class test_EmptyObjectForFireBig: test_EmptyObjectForBubbles {
        XEH_ENABLED;
    };
    class test_EmptyObjectForSmoke: test_EmptyObjectForBubbles {
        XEH_ENABLED;
    };

    class Land_File1_F;
    class Intel_File1_F: Land_File1_F {
        XEH_ENABLED;
    };

    class Land_File2_F;
    class Intel_File2_F: Land_File2_F {
        XEH_ENABLED;
    };

    class Land_Photos_V3_F;
    class Intel_Photos_F: Land_Photos_V3_F {
        XEH_ENABLED;
    };

    class ModuleEmpty_F: Thing {
        XEH_ENABLED;
    };

    class LogicSectorBase_F: Logic {
        XEH_ENABLED;
    };

    class Furniture_base_F;
    class Land_OfficeTable_01_F: Furniture_base_F {
        XEH_ENABLED;
    };

    class SportItems_base_F;
    class Land_Balloon_01_air_F: SportItems_base_F {
        XEH_ENABLED;
    };
    class Land_Balloon_01_water_F: Land_Balloon_01_air_F {
        XEH_ENABLED;
    };

    class Helicopter;
    class ParachuteBase: Helicopter {
        XEH_ENABLED;
    };

    class StaticWeapon;
    class StaticCannon: StaticWeapon {
        XEH_ENABLED;
    };

    class StaticMortar;
    class Mortar_01_base_F: StaticMortar {
        XEH_ENABLED;
    };

    class Land_Campfire_F;
    class Campfire_burning_F: Land_Campfire_F {
        XEH_ENABLED;
    };

    class Land_FirePlace_F;
    class FirePlace_burning_F: Land_FirePlace_F {
        XEH_ENABLED;
    };

    class House_F;
    class PowerLines_base_F: House_F {
        XEH_ENABLED;
    };
    class Land_Communication_anchor_F: House_F {
        XEH_ENABLED;
    };
    class Land_Communication_F: House_F {
        XEH_ENABLED;
    };

    class House_Small_F;
    class PowerLines_Small_base_F: House_Small_F {
        XEH_ENABLED;
    };

    class Land_MetalBarrel_empty_F;
    class MetalBarrel_burning_F: Land_MetalBarrel_empty_F {
        XEH_ENABLED;
    };

    class FlagCarrierCore;
    class FlagChecked_F: FlagCarrierCore {
        XEH_ENABLED;
    };

    class ThingX;
    class ReammoBox_F: ThingX {
        XEH_ENABLED;
    };

    class C_man_w_worker_F;
    class C_scientist_F: C_man_w_worker_F {
        XEH_ENABLED;
    };

    class C_man_1;
    class C_journalist_F: C_man_1 {
        XEH_ENABLED;
    };
    class C_Driver_1_F: C_man_1 {
        XEH_ENABLED;
    };

    class Civilian_F;
    class VirtualMan_F: Civilian_F {
        XEH_ENABLED;
    };
    class VirtualSpectator_F: VirtualMan_F {
        XEH_ENABLED;
    };

    class PlaneWreck;
    class Plane_Fighter_03_wreck_F: PlaneWreck {
        XEH_ENABLED;
    };

    class Wreck_base_F;
    class Land_Wreck_Heli_Attack_01_F: Wreck_base_F {
        XEH_ENABLED;
    };

    class Land_TentA_F;
    class Respawn_TentA_F: Land_TentA_F {
        XEH_ENABLED;
    };

    class Land_TentDome_F;
    class Respawn_TentDome_F: Land_TentDome_F {
        XEH_ENABLED;
    };

    class Land_Sleeping_bag_F;
    class Respawn_Sleeping_bag_F: Land_Sleeping_bag_F {
        XEH_ENABLED;
    };

    class Land_Sleeping_bag_blue_F;
    class Respawn_Sleeping_bag_blue_F: Land_Sleeping_bag_blue_F {
        XEH_ENABLED;
    };

    class Land_Sleeping_bag_brown_F;
    class Respawn_Sleeping_bag_brown_F: Land_Sleeping_bag_brown_F {
        XEH_ENABLED;
    };

    // backwards comp, inert
    class SLX_XEH_Logic: Logic {
        scope = 1;
        displayName = "XEH Initialization Logic";
    };

    // fix taru pods, broken since v1.60
    class Pod_Heli_Transport_04_crewed_base_F: StaticWeapon {
        class EventHandlers;
    };

    class Slingload_base_F;
    class Pod_Heli_Transport_04_base_F: Slingload_base_F {
        class EventHandlers;

    };
    class Land_Pod_Heli_Transport_04_ammo_F: Pod_Heli_Transport_04_base_F {
        class EventHandlers: EventHandlers {
            class XEH_CLASS: XEH_CLASS_BASE {};
        };
    };

    class Land_Pod_Heli_Transport_04_bench_F: Pod_Heli_Transport_04_crewed_base_F {
        class EventHandlers: EventHandlers {
            class XEH_CLASS: XEH_CLASS_BASE {};
        };
    };

    class Land_Pod_Heli_Transport_04_box_F: Pod_Heli_Transport_04_base_F {
        class EventHandlers: EventHandlers {
            class XEH_CLASS: XEH_CLASS_BASE {};
        };
    };

    class Land_Pod_Heli_Transport_04_covered_F: Pod_Heli_Transport_04_crewed_base_F {
        class EventHandlers: EventHandlers {
            class XEH_CLASS: XEH_CLASS_BASE {};
        };
    };

    class Land_Pod_Heli_Transport_04_fuel_F: Pod_Heli_Transport_04_base_F {
        class EventHandlers: EventHandlers {
            class XEH_CLASS: XEH_CLASS_BASE {};
        };
    };

    class Land_Pod_Heli_Transport_04_medevac_F: Pod_Heli_Transport_04_crewed_base_F {
        class EventHandlers: EventHandlers {
            class XEH_CLASS: XEH_CLASS_BASE {};
        };
    };

    class Land_Pod_Heli_Transport_04_repair_F: Pod_Heli_Transport_04_base_F {
        class EventHandlers: EventHandlers {
            class XEH_CLASS: XEH_CLASS_BASE {};
        };
    };

    class Land_Pod_Heli_Transport_04_ammo_black_F: Land_Pod_Heli_Transport_04_ammo_F {
        class EventHandlers: EventHandlers {
            class XEH_CLASS: XEH_CLASS_BASE {};
        };
    };

    class Land_Pod_Heli_Transport_04_bench_black_F: Land_Pod_Heli_Transport_04_bench_F {
        class EventHandlers: EventHandlers {
            class XEH_CLASS: XEH_CLASS_BASE {};
        };
    };

    class Land_Pod_Heli_Transport_04_box_black_F: Land_Pod_Heli_Transport_04_box_F {
        class EventHandlers: EventHandlers {
            class XEH_CLASS: XEH_CLASS_BASE {};
        };
    };

    class Land_Pod_Heli_Transport_04_covered_black_F: Land_Pod_Heli_Transport_04_covered_F {
        class EventHandlers: EventHandlers {
            class XEH_CLASS: XEH_CLASS_BASE {};
        };
    };

    class Land_Pod_Heli_Transport_04_fuel_black_F: Land_Pod_Heli_Transport_04_fuel_F {
        class EventHandlers: EventHandlers {
            class XEH_CLASS: XEH_CLASS_BASE {};
        };
    };

    class Land_Pod_Heli_Transport_04_medevac_black_F: Land_Pod_Heli_Transport_04_medevac_F {
        class EventHandlers: EventHandlers {
            class XEH_CLASS: XEH_CLASS_BASE {};
        };
    };

    class Land_Pod_Heli_Transport_04_repair_black_F: Land_Pod_Heli_Transport_04_repair_F {
        class EventHandlers: EventHandlers {
            class XEH_CLASS: XEH_CLASS_BASE {};
        };
    };

    // Similar but different issue with the actual taru helicopter. only poking the "init" entry fixes it. cause unknown.
    class Helicopter_Base_F;
    class Helicopter_Base_H: Helicopter_Base_F {
        class EventHandlers;
    };
    class Heli_Transport_04_base_F: Helicopter_Base_H {
        class EventHandlers: EventHandlers {
            init = "if (local (_this select 0)) then {[(_this select 0), """", false, false] call bis_fnc_initVehicle;};";
        };
    };

    // APEX
    class Plane_Base_F;
    class Plane_Civil_01_base_F: Plane_Base_F {
        XEH_ENABLED;
    };

    class B_CTRG_Soldier_3_F;
    class B_CTRG_Miller_F: B_CTRG_Soldier_3_F {
        XEH_ENABLED;
    };

    class Land_PowerLine_01_pole_junction_F: PowerLines_Small_base_F {
        XEH_ENABLED;
    };
    class Land_PowerLine_01_pole_lamp_F: PowerLines_Small_base_F {
        XEH_ENABLED;
    };
    class Land_PowerLine_01_pole_lamp_off_F: PowerLines_Small_base_F {
        XEH_ENABLED;
    };
    class Land_PowerLine_01_pole_small_F: PowerLines_Small_base_F {
        XEH_ENABLED;
    };
    class Land_PowerLine_01_pole_tall_F: PowerLines_Small_base_F {
        XEH_ENABLED;
    };
    class Land_PowerLine_01_pole_transformer_F: PowerLines_Small_base_F {
        XEH_ENABLED;
    };

    // ARGO
    class Land_Laptop_02_F;
    class Land_Laptop_02_unfolded_F: Land_Laptop_02_F {
        XEH_ENABLED;
    };
};
