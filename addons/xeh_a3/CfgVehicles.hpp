class CfgVehicles {
    class PlaneWreck;
    class Plane_Fighter_03_wreck_F: PlaneWreck
    {
        XEH_DISABLED;
    };

    class Land_FirePlace_F;
    class FirePlace_burning_F: Land_FirePlace_F {
        XEH_ENABLED;
    };
    class House_F;
    class Land_Communication_anchor_F: House_F {
        XEH_ENABLED;
    };
    class Land_Communication_F: House_F {
        XEH_ENABLED;
    };

    class Animal_Base_F;
    class Snake_random_F: Animal_Base_F {
        delete Eventhandlers;
    };
    class Fin_Base_F;
    class Fin_random_F: Fin_Base_F {
        delete Eventhandlers; // Eventhandlers
    };
    class Alsatian_Base_F;
    class Alsatian_Random_F: Alsatian_Base_F {
        delete Eventhandlers; // Eventhandlers
    };
    class Goat_Base_F;
    class Goat_random_F: Goat_Base_F {
        delete Eventhandlers; // Eventhandlers
    };
    class Sheep_random_F: Animal_Base_F {
        delete Eventhandlers; // Eventhandlers
    };

    class FlagCarrierCore;
    class FlagChecked_F: FlagCarrierCore {
        XEH_ENABLED;
    };

    class Thing;
    class test_EmptyObjectForBubbles: Thing {
        XEH_ENABLED;
    };
    class thingX;
    class ReammoBox_F: thingX {
        XEH_ENABLED;
    };
    class test_EmptyObjectForFireBig: test_EmptyObjectForBubbles {
        XEH_ENABLED;
    };
    class test_EmptyObjectForSmoke: test_EmptyObjectForBubbles {
        XEH_ENABLED;
    };

    class WeaponHolder;
    class B_AssaultPack_khk_holder: WeaponHolder {
        XEH_ENABLED;
    };

    class StaticWeapon;
    class StaticMortar;
    class Mortar_01_Base_F: StaticMortar {
        delete Eventhandlers;
    };
    class Static_Designator_01_base_F: StaticWeapon {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };
    class Static_Designator_02_base_F: StaticWeapon {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };

    class Helicopter;
    class Helicopter_Base_F: Helicopter {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };
    class Heli_Attack_01_base_F: Helicopter_Base_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };
    class Heli_Light_01_unarmed_base_F;
    class Heli_Light_01_civil_base_F: Heli_Light_01_unarmed_base_F {
        delete EventHandlers;
    };

    class Ship;
    class Ship_F: Ship {
        class Eventhandlers: DefaultEventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class Boat_Civil_01_base_F: Ship_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };

    class C_Boat_Civil_01_rescue_F: Boat_Civil_01_base_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };

    class C_Boat_Civil_01_police_F: Boat_Civil_01_base_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };

    class B_Soldier_base_F;
    class B_RangeMaster_F: B_Soldier_base_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };
    class B_Story_SF_Captain_F: B_Soldier_base_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };
    class B_Story_Protagonist_F: B_Soldier_base_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };
    class B_Story_Engineer_F: B_Soldier_base_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };
    class B_Story_Pilot_F: B_Soldier_base_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };
    class B_CTRG_soldier_GL_LAT_F: B_Soldier_base_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };
    class B_CTRG_soldier_engineer_exp_F: B_Soldier_base_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };
    class B_CTRG_soldier_M_medic_F: B_Soldier_base_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };
    class B_CTRG_soldier_AR_A_F: B_Soldier_base_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };

    class B_Soldier_F;
    class Underwear_F: B_Soldier_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };

    class C_man_w_worker_F;
    class C_scientist_F: C_man_w_worker_F {
        class Eventhandlers { EXTENDED_EVENTHANDLERS };
    };

    class Civilian_F;
    class C_man_1: Civilian_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };
    class C_man_hunter_1_F: C_man_1 {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };
    class C_man_pilot_F: C_man_1 {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };
    class C_journalist_F: C_man_1 {
        class Eventhandlers { EXTENDED_EVENTHANDLERS };
    };
    class C_Driver_1_F: C_man_1 {
        class Eventhandlers { EXTENDED_EVENTHANDLERS };
    };
    class C_Soldier_VR_F: C_man_1 {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };
    class VirtualMan_F: Civilian_F {
        class Eventhandlers { EXTENDED_EVENTHANDLERS };
    };
    class C_Orestes;
    class C_Nikos: C_Orestes {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };

    class B_G_Soldier_F;
    class I_G_Story_SF_Captain_F: B_G_Soldier_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };
    class I_G_Story_Protagonist_F: B_G_Soldier_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };
    class I_G_resistanceLeader_F: I_G_Story_Protagonist_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };
    class SoldierGB;
    class I_G_Soldier_base_F: SoldierGB {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };

    class LandVehicle;
    class Car: LandVehicle {
        class Eventhandlers;
    };
    class Car_F: Car {
        class Eventhandlers: DefaultEventHandlers { EXTENDED_EVENTHANDLERS };
    };
    class Quadbike_01_base_F: Car_F {
        //                delete Eventhandlers; // Eventhandlers
    };
    class C_Quadbike_01_F: Quadbike_01_base_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };
    class I_G_Quadbike_01_F: Quadbike_01_base_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };


    class Hatchback_01_base_F;
    class C_Hatchback_01_F: Hatchback_01_base_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };
    class Hatchback_01_sport_base_F;
    class C_Hatchback_01_sport_F: Hatchback_01_sport_base_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };

    class Offroad_01_base_F;
    class Offroad_01_armed_base_F;
    class Offroad_01_civil_base_F;
    class Offroad_01_military_base_F;
    class Offroad_01_repair_military_base_F;
    class C_Offroad_01_F: Offroad_01_civil_base_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };
    class Offroad_01_repair_base_F: Offroad_01_base_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };
    class B_G_Offroad_01_repair_F: Offroad_01_repair_military_base_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };
    class I_G_Offroad_01_F: Offroad_01_military_base_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };
    class I_G_Offroad_01_armed_F: Offroad_01_armed_base_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };

    class SUV_01_base_F;
    class C_SUV_01_F: SUV_01_base_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };

    class Truck_F;
    class Van_01_base_F: Truck_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };
    class Van_01_fuel_base_F;
    class Van_01_transport_base_F;
    class I_G_Van_01_transport_F: Van_01_transport_base_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };
    class C_Van_01_fuel_F: Van_01_fuel_base_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };
    class I_G_Van_01_fuel_F: Van_01_fuel_base_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };
    class C_Kart_01_F_Base;
    class C_Kart_01_F: C_Kart_01_F_Base {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };

    class Wheeled_APC_F;
    class APC_Wheeled_03_base_F: Wheeled_APC_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };

    class Tank;
    class Tank_F: Tank {
        class Eventhandlers: DefaultEventHandlers { EXTENDED_EVENTHANDLERS };
    };

    class APC_Tracked_02_base_F: Tank_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };
    class MBT_03_base_F: Tank_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };

    class B_APC_Tracked_01_base_F;
    class B_APC_Tracked_01_AA_F: B_APC_Tracked_01_base_F {
        class Eventhandlers: Eventhandlers {
            DELETE_EVENTHANDLERS
        };
    };
};
