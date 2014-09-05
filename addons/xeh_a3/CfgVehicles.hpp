class CfgVehicles {
        class PlaneWreck;
        class Plane_Fighter_03_wreck_F: PlaneWreck
        {
                XEH_DISABLED;
        };

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
                class EventHandlers { EXTENDED_EVENTHANDLERS };
        };
        class test_EmptyObjectForFireBig: test_EmptyObjectForBubbles {
                class EventHandlers { EXTENDED_EVENTHANDLERS };
        };
        class test_EmptyObjectForSmoke: test_EmptyObjectForBubbles {
                class EventHandlers { EXTENDED_EVENTHANDLERS };
        };
        class WeaponHolder;
        class B_AssaultPack_khk_holder: WeaponHolder {
                class EventHandlers { EXTENDED_EVENTHANDLERS };
        };
        class StaticMortar;
        class Mortar_01_Base_F: StaticMortar {
                class EventHandlers { EXTENDED_EVENTHANDLERS };
        };
        class Air;
        class Helicopter: Air { class EventHandlers; };
        class Helicopter_Base_F: Helicopter {
                class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
        };
        class Ship;
        class Ship_F: Ship {
                class EventHandlers: DefaultEventHandlers { EXTENDED_EVENTHANDLERS };
        };
        class B_Soldier_base_F;
        class B_Soldier_F: B_Soldier_base_F { class EventHandlers; };
        class Underwear_F: B_Soldier_F {
                class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
        };
        class Car;
        class Car_F: Car {
                class EventHandlers: DefaultEventHandlers { EXTENDED_EVENTHANDLERS };
        };
        class Quadbike_Base_F: Car_F {
                class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
        };
        class Tank;
        class Tank_F: Tank {
            class EventHandlers: DefaultEventHandlers { EXTENDED_EVENTHANDLERS };
        };
};
