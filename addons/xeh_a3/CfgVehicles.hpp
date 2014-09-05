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
                delete EventHandlers;
        };

        class FlagCarrierCore;
        class FlagChecked_F: FlagCarrierCore {
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

        class WeaponHolder;
        class B_AssaultPack_khk_holder: WeaponHolder {
                XEH_ENABLED;
        };

        class StaticMortar;
        class Mortar_01_Base_F: StaticMortar {
                delete EventHandlers;
        };

        class Helicopter;
        class Helicopter_Base_F: Helicopter {
                delete EventHandlers;
        };

        class Ship;
        class Ship_F: Ship {
                delete EventHandlers; // DefaultEventhandlers
        };
        class Boat_Civil_01_base_F: Ship_F {
                delete EventHandlers; // Eventhandlers
        };
        class C_Boat_Civil_01_rescue_F: Boat_Civil_01_base_F {
                delete EventHandlers; // Eventhandlers
        };
        class C_Boat_Civil_01_police_F: Boat_Civil_01_base_F {
                delete EventHandlers; // Eventhandlers
        };

        class B_Soldier_base_F;
        class B_RangeMaster_F: B_Soldier_base_F {
                delete EventHandlers;
        };
        class B_Story_SF_Captain_F: B_Soldier_base_F {
                delete EventHandlers;
        };
        class B_Story_Protagonist_F: B_Soldier_base_F {
                delete EventHandlers;
        };
        class B_Story_Engineer_F: B_Soldier_base_F {
                delete EventHandlers;
        };
        class B_Story_Pilot_F: B_Soldier_base_F {
                delete EventHandlers;
        };
        class B_CTRG_soldier_GL_LAT_F: B_Soldier_base_F {
                delete EventHandlers;
        };
        class B_CTRG_soldier_engineer_exp_F: B_Soldier_base_F {
                delete EventHandlers;
        };
        class B_CTRG_soldier_M_medic_F: B_Soldier_base_F {
                delete EventHandlers;
        };
        class B_CTRG_soldier_AR_A_F: B_Soldier_base_F {
                delete EventHandlers;
        };
        
        class B_Soldier_F;
        class Underwear_F: B_Soldier_F {
                delete EventHandlers;
        };

        class C_man_w_worker_F;
        class C_scientist_F: C_man_w_worker_F {
                delete EventHandlers;
        };

        class Civilian_F;
        class C_man_1: Civilian_F {
                delete EventHandlers;
        };
        class C_man_hunter_1_F: C_man_1 {
                delete EventHandlers;
        };
        class C_man_pilot_F: C_man_1 {
                delete EventHandlers;
        };
        class C_journalist_F: C_man_1 {
                delete EventHandlers;
        };
        class C_Driver_1_F: C_man_1 {
                delete EventHandlers;
        };
        class C_Soldier_VR_F: C_man_1 {
                delete EventHandlers;
        };

        class C_Orestes;
        class C_Nikos: C_Orestes {
                delete EventHandlers;
        };

        class SoldierGB;
        class I_G_Soldier_base_F: SoldierGB {
                delete EventHandlers;
        };

        class Car;
        class Car_F: Car {
                delete EventHandlers; // DefaultEventhandlers
        };
        class Quadbike_01_base_F: Car_F {
                delete EventHandlers; // Eventhandlers
        };
        class C_Quadbike_01_F: Quadbike_01_base_F {
                delete EventHandlers; // Eventhandlers
        };
        class I_G_Quadbike_01_F: Quadbike_01_base_F {
                delete EventHandlers; // Eventhandlers
        };

        class Hatchback_01_base_F;
        class C_Hatchback_01_F: Hatchback_01_base_F {
                delete EventHandlers; // Eventhandlers
        };
        class C_Hatchback_01_sport_F: Hatchback_01_base_F {
                delete EventHandlers; // Eventhandlers
        };

        class Offroad_01_base_F;
        class C_Offroad_01_F: Offroad_01_base_F {
                delete EventHandlers; // Eventhandlers
        };
        class Offroad_01_repair_base_F: Offroad_01_base_F {
                delete EventHandlers; // Eventhandlers
        };
        class B_G_Offroad_01_repair_F: Offroad_01_repair_base_F {
                delete EventHandlers; // Eventhandlers
        };
        class I_G_Offroad_01_F: Offroad_01_base_F{
                delete EventHandlers; // Eventhandlers
        };
        class Offroad_01_armed_base_F;
        class I_G_Offroad_01_armed_F: Offroad_01_armed_base_F {
                delete EventHandlers; // Eventhandlers
        };

        class SUV_01_base_F;
        class C_SUV_01_F: SUV_01_base_F {
                delete EventHandlers; // Eventhandlers
        };

        class Truck_F;
        class Van_01_base_F: Truck_F {
                delete EventHandlers; // Eventhandlers
        };
        class I_G_Van_01_transport_F: Van_01_base_F {
                delete EventHandlers; // Eventhandlers
        };
        class C_Van_01_fuel_F: Van_01_base_F {
                delete EventHandlers; // Eventhandlers
        };
        class I_G_Van_01_fuel_F: Van_01_base_F {
                delete EventHandlers; // Eventhandlers
        };

        class C_Kart_01_F_Base;
        class C_Kart_01_F: C_Kart_01_F_Base {
                delete EventHandlers; // Eventhandlers
        };

        class Wheeled_APC_F;
        class APC_Wheeled_03_base_F: Wheeled_APC_F {
                delete EventHandlers; // Eventhandlers
        };

        class Tank;
        class Tank_F: Tank {
            delete EventHandlers; // DefaultEventhandlers
        };
        class APC_Tracked_02_base_F: Tank_F {
                delete EventHandlers; // Eventhandlers
        };
        class MBT_03_base_F: Tank_F {
                delete EventHandlers; // Eventhandlers
        };

        class B_APC_Tracked_01_base_F;
        class B_APC_Tracked_01_AA_F: B_APC_Tracked_01_base_F {
                delete EventHandlers; // Eventhandlers
        };
};
