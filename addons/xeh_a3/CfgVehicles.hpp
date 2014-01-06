class CfgVehicles {
        class All {
                class EventHandlers { EXTENDED_EVENTHANDLERS };
        };
        class Air;
        class Helicopter: Air {
                class Eventhandlers: DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
        };
        class Plane: Air {
                class Eventhandlers: DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
        };
        class StaticWeapon;
        class StaticCannon: StaticWeapon {
                class Eventhandlers { EXTENDED_EVENTHANDLERS };
        };

        // No need to do for logics
        /*
        class Logic;
        class Module_F: Logic {
                class Eventhandlers { EXTENDED_EVENTHANDLERS };
        };
        class BIS_Effect_FilmGrain: Module_F {
                class Eventhandlers { EXTENDED_EVENTHANDLERS };
        };
        class BIS_Effect_Day: BIS_Effect_FilmGrain {
                class Eventhandlers { EXTENDED_EVENTHANDLERS };
        };
        class BIS_Effect_MovieNight: BIS_Effect_FilmGrain {
                class Eventhandlers { EXTENDED_EVENTHANDLERS };
        };
        class BIS_Effect_Sepia: BIS_Effect_FilmGrain {
                class Eventhandlers { EXTENDED_EVENTHANDLERS };
        };
        class Site_Military_Base: Module_F {
                class Eventhandlers { EXTENDED_EVENTHANDLERS };
        };
        class Site_FT_Base: Module_F {
                class Eventhandlers { EXTENDED_EVENTHANDLERS };
        };
        class Site_Ambient: Module_F {
                class Eventhandlers { EXTENDED_EVENTHANDLERS };
        };
        class Site_Minefield: Module_F {
                class Eventhandlers { EXTENDED_EVENTHANDLERS };
        };
        class Site_Patrol: Module_F {
                class Eventhandlers { EXTENDED_EVENTHANDLERS };
        };
        class SupportRequester: Module_F {
                class Eventhandlers { EXTENDED_EVENTHANDLERS };
        };
        class SupportProvider_Artillery: Module_F {
                class Eventhandlers { EXTENDED_EVENTHANDLERS };
        };
        class SupportProvider_Virtual_Artillery: Module_F {
                class Eventhandlers { EXTENDED_EVENTHANDLERS };
        };
        class SupportProvider_CAS_Heli: Module_F {
                class Eventhandlers { EXTENDED_EVENTHANDLERS };
        };
        class SupportProvider_Virtual_CAS_Heli: Module_F {
                class Eventhandlers { EXTENDED_EVENTHANDLERS };
        };
        class SupportProvider_CAS_Bombing: Module_F {
                class Eventhandlers { EXTENDED_EVENTHANDLERS };
        };
        class SupportProvider_Virtual_CAS_Bombing: Module_F {
                class Eventhandlers { EXTENDED_EVENTHANDLERS };
        };
        class SupportProvider_Drop: Module_F {
                class Eventhandlers { EXTENDED_EVENTHANDLERS };
        };
        class SupportProvider_Virtual_Drop: Module_F {
                class Eventhandlers { EXTENDED_EVENTHANDLERS };
        };
        class SupportProvider_Transport: Module_F {
                class Eventhandlers { EXTENDED_EVENTHANDLERS };
        };
        class SupportProvider_Virtual_Transport: Module_F {
                class Eventhandlers { EXTENDED_EVENTHANDLERS };
        };
        class UAVCommand: Module_F {
                class Eventhandlers { EXTENDED_EVENTHANDLERS };
        };
        */
        class Land_FirePlace_F;
        class FirePlace_burning_F: Land_FirePlace_F {
                class EventHandlers { EXTENDED_EVENTHANDLERS };
        };
        class House_F;
        class Land_Communication_anchor_F: House_F {
                class EventHandlers { EXTENDED_EVENTHANDLERS };
        };
        class Land_Communication_F: House_F {
                class EventHandlers { EXTENDED_EVENTHANDLERS };
        };
        class Animal;
        class Animal_Base_F: Animal { class EventHandlers; };
        class Snake_random_F: Animal_Base_F {
                class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
        };
        class FlagCarrierCore;
        class FlagChecked_F: FlagCarrierCore {
                class EventHandlers { EXTENDED_EVENTHANDLERS };
        };
        class Thing;
        class test_EmptyObjectForBubbles: Thing {
                class Eventhandlers { EXTENDED_EVENTHANDLERS };
        };
        class test_EmptyObjectForFireBig: test_EmptyObjectForBubbles {
                class Eventhandlers { EXTENDED_EVENTHANDLERS };
        };
        class test_EmptyObjectForSmoke: test_EmptyObjectForBubbles {
                class Eventhandlers { EXTENDED_EVENTHANDLERS };
        };
        class WeaponHolder;
        class B_AssaultPack_khk_holder: WeaponHolder {
                class Eventhandlers { EXTENDED_EVENTHANDLERS };
        };
        class StaticMortar;
        class Mortar_01_Base_F: StaticMortar {
                class Eventhandlers { EXTENDED_EVENTHANDLERS };
        };
        class Helicopter_Base_F: Helicopter {
                class Eventhandlers: Eventhandlers { EXTENDED_EVENTHANDLERS };
        };
        class Ship;
        class Ship_F: Ship {
                class Eventhandlers: DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
        };
        class B_Soldier_base_F;
        class B_Soldier_F: B_Soldier_base_F { class EventHandlers; };
        class Underwear_F: B_Soldier_F {
                class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
        };
        class Car;
        class Car_F: Car {
                class Eventhandlers: DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
        };
        class Offroad_Base: Car_F { class Eventhandlers; };
        class c_offroad: Offroad_Base {
                class EventHandlers: Eventhandlers { EXTENDED_EVENTHANDLERS };
        };
        class Quadbike_Base_F: Car_F {
                class EventHandlers: Eventhandlers { EXTENDED_EVENTHANDLERS };
        };
        class Wreck_base_F;
        class Land_Wreck_Commanche_F: Wreck_base_F {
                class EventHandlers { EXTENDED_EVENTHANDLERS };
        };
        class Tank;
        class Tank_F: Tank {
            class Eventhandlers: DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
        };
};
