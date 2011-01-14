// Make event handler classes have the extended event handlers.
class CfgVehicles {
	class All {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Static: All { class EventHandlers {}; }; // Manually created
	class LandVehicle;
	class Car: LandVehicle {
		class Eventhandlers: DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class Tank: LandVehicle {
		class Eventhandlers: DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class Air;
	class Helicopter: Air {
		class Eventhandlers: DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class Plane: Air {
		class Eventhandlers: DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class AllVehicles;
	class Ship: AllVehicles {
		class Eventhandlers: DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
	};
	/*
	class ParachuteBase: Helicopter {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	*/
	class StaticWeapon;
	class StaticCannon: StaticWeapon {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	/*
	class BIS_Steerable_Parachute: Plane {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	*/
	class Animal;
	class CAAnimalBase: Animal {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class StaticMortar;
	class M252: StaticMortar {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class 2b14_82mm: StaticMortar {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class SoldierWB;
	class FR_Base: SoldierWB { class EventHandlers; };
	class FR_Miles: FR_Base {
		class EventHandlers: EventHandlers { handleidentity = "true"; EXTENDED_EVENTHANDLERS };
	};
	class FR_GL: FR_Base { class EventHandlers; };
	class FR_Cooper: FR_GL {
		class EventHandlers: EventHandlers { handleidentity = "true"; EXTENDED_EVENTHANDLERS };
	};
	class FR_Marksman: FR_Base { class EventHandlers; };
	class FR_Sykes: FR_Marksman {
		class EventHandlers: EventHandlers { handleidentity = "true"; EXTENDED_EVENTHANDLERS };
	};
	class FR_Corpsman: FR_Base { class EventHandlers; };
	class FR_OHara: FR_Corpsman {
		class EventHandlers: EventHandlers { handleidentity = "true"; EXTENDED_EVENTHANDLERS };
	};
	class FR_AR: FR_Base { class EventHandlers; };
	class FR_Rodriguez: FR_AR {
		class EventHandlers: EventHandlers { handleidentity = "true"; EXTENDED_EVENTHANDLERS };
	};
	class Civilian;
	class TK_CIV_Takistani_Base_EP1: Civilian { class EventHandlers; };
	class TK_CIV_Takistani01_EP1: TK_CIV_Takistani_Base_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TK_CIV_Takistani02_EP1: TK_CIV_Takistani_Base_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TK_CIV_Takistani03_EP1: TK_CIV_Takistani_Base_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TK_CIV_Takistani04_EP1: TK_CIV_Takistani_Base_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TK_CIV_Takistani05_EP1: TK_CIV_Takistani_Base_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TK_CIV_Takistani06_EP1: TK_CIV_Takistani_Base_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Woman_EP1: Civilian { class EventHandlers; };
	class TK_CIV_Woman01_EP1: Woman_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TK_CIV_Woman02_EP1: TK_CIV_Woman01_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TK_CIV_Woman03_EP1: TK_CIV_Woman01_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class CIV_EuroWoman01_EP1: Woman_EP1 { class EventHandlers; };
	class Dr_Annie_Baker_EP1: CIV_EuroWoman01_EP1 {
		class EventHandlers: EventHandlers { handleidentity = "true"; EXTENDED_EVENTHANDLERS };
	};
	class CIV_EuroWoman02_EP1: CIV_EuroWoman01_EP1 { class EventHandlers; };
	class Rita_Ensler_EP1: CIV_EuroWoman02_EP1 {
		class EventHandlers: EventHandlers { handleidentity = "true"; EXTENDED_EVENTHANDLERS };
	};
	class CIV_EuroMan01_EP1: Civilian { class EventHandlers; };
	class Haris_Press_EP1: CIV_EuroMan01_EP1 {
		class EventHandlers: EventHandlers { handleidentity = "true"; EXTENDED_EVENTHANDLERS };
	};
	class CIV_EuroMan02_EP1: CIV_EuroMan01_EP1 { class EventHandlers; };
	class Dr_Hladik_EP1: CIV_EuroMan02_EP1 {
		class EventHandlers: EventHandlers { handleidentity = "true"; EXTENDED_EVENTHANDLERS };
	};
	class SoldierEB;
	class TK_INS_Soldier_Base_EP1: SoldierEB { class EventHandlers; };
	class TK_INS_Soldier_EP1: TK_INS_Soldier_Base_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TK_INS_Soldier_2_EP1: TK_INS_Soldier_Base_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TK_INS_Soldier_3_EP1: TK_INS_Soldier_Base_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TK_INS_Soldier_4_EP1: TK_INS_Soldier_Base_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TK_INS_Soldier_AA_EP1: TK_INS_Soldier_Base_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TK_INS_Soldier_AT_EP1: TK_INS_Soldier_Base_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TK_INS_Soldier_TL_EP1: TK_INS_Soldier_Base_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TK_INS_Soldier_Sniper_EP1: TK_INS_Soldier_Base_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TK_INS_Soldier_AR_EP1: TK_INS_Soldier_Base_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TK_INS_Soldier_MG_EP1: TK_INS_Soldier_Base_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TK_INS_Bonesetter_EP1: TK_INS_Soldier_Base_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TK_INS_Warlord_EP1: TK_INS_Soldier_Base_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class SoldierGB;
	class TK_GUE_Soldier_Base_EP1: SoldierGB { class EventHandlers; };
	class TK_GUE_Soldier_EP1: TK_GUE_Soldier_Base_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TK_GUE_Soldier_2_EP1: TK_GUE_Soldier_Base_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TK_GUE_Soldier_3_EP1: TK_GUE_Soldier_Base_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TK_GUE_Soldier_4_EP1: TK_GUE_Soldier_Base_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TK_GUE_Soldier_5_EP1: TK_GUE_Soldier_Base_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TK_GUE_Soldier_AA_EP1: TK_GUE_Soldier_Base_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TK_GUE_Soldier_AT_EP1: TK_GUE_Soldier_Base_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TK_GUE_Soldier_HAT_EP1: TK_GUE_Soldier_Base_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TK_GUE_Soldier_TL_EP1: TK_GUE_Soldier_Base_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TK_GUE_Soldier_Sniper_EP1: TK_GUE_Soldier_Base_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TK_GUE_Soldier_AR_EP1: TK_GUE_Soldier_Base_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TK_GUE_Soldier_MG_EP1: TK_GUE_Soldier_Base_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TK_GUE_Bonesetter_EP1: TK_GUE_Soldier_Base_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TK_GUE_Warlord_EP1: TK_GUE_Soldier_Base_EP1 {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class HelicopterWreck;
	class AH1ZWreck: HelicopterWreck {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class MH60Wreck: HelicopterWreck {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class PlaneWreck;
	class AV8BWreck: PlaneWreck {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class Mi17Wreck: HelicopterWreck {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class Land_Fire;
	class Land_Fire_burning: Land_Fire {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Land_Campfire;
	class Land_Campfire_burning: Land_Campfire {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Land_Fire_barrel;
	class Land_Fire_barrel_burning: Land_Fire_barrel {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrier;
	class FlagCarrierUSA: FlagCarrier {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierCDF: FlagCarrierUSA {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierRU: FlagCarrierUSA {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierINS: FlagCarrierUSA {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierGUE: FlagCarrierUSA {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierCore;
	class FlagCarrierChecked: FlagCarrierCore {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TargetBase;
	class TargetPopUpTarget: TargetBase {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TargetEpopup: TargetBase {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Land_Barrack2;
	class Barrack2: Land_Barrack2 {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class Grave;
	class Mass_grave: Grave {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Tracked_APC;
	class AAV: Tracked_APC {
		class EventHandlers: DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class Pickup_PK_base: Car { class Eventhandlers; };
	class Pickup_PK_TK_GUE_EP1: Pickup_PK_base {
		class EventHandlers: Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class A10: Plane {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class A10Wreck: PlaneWreck {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class SU25Wreck: PlaneWreck {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class Mi24Wreck: HelicopterWreck {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class F35bWreck: PlaneWreck {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class MQ9PredatorWreck: PlaneWreck {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class MV22Wreck: PlaneWreck {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class C130JWreck: PlaneWreck {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class Ka52Wreck: HelicopterWreck {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class UH1YWreck: HelicopterWreck {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class Su34: Plane {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class AH6_Base_EP1;
	class AH6X_EP1: AH6_Base_EP1 {
		class EventHandlers: DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
	};
	/*
	class Steerable_Parachute_EP1: Plane {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	*/
	class l39Wreck: PlaneWreck {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierUNO_EP1: FlagCarrier {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierRedCrystal_EP1: FlagCarrierUNO_EP1 {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierTFKnight_EP1: FlagCarrierUNO_EP1 {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierCDFEnsign_EP1: FlagCarrierUNO_EP1 {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierRedCross_EP1: FlagCarrierUNO_EP1 {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierUSArmy_EP1: FlagCarrierUNO_EP1 {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierTKMilitia_EP1: FlagCarrierUNO_EP1 {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierRedCrescent_EP1: FlagCarrierUNO_EP1 {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierGermany_EP1: FlagCarrierUNO_EP1 {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierNATO_EP1: FlagCarrierUNO_EP1 {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierBIS_EP1: FlagCarrierUNO_EP1 {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierCzechRepublic_EP1: FlagCarrierUNO_EP1 {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierPOWMIA_EP1: FlagCarrierUNO_EP1 {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierBLUFOR_EP1: FlagCarrierUNO_EP1 {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierOPFOR_EP1: FlagCarrierUNO_EP1 {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierINDFOR_EP1: FlagCarrierUNO_EP1 {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierTakistan_EP1: FlagCarrierUNO_EP1 {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierTakistanKingdom_EP1: FlagCarrierUNO_EP1 {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierUSA_EP1: FlagCarrierUNO_EP1 {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierCDF_EP1: FlagCarrierUNO_EP1 {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierWhite_EP1: FlagCarrierUNO_EP1 {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class MQ9PredatorB;
	class CruiseMissile2: MQ9PredatorB {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	
	class FlagCarrierIONblack_PMC: FlagCarrier {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierIONwhite_PMC: FlagCarrierIONblack_PMC {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Soldier_Base_PMC: SoldierGB { class EventHandlers; };
	class Soldier_PMC: Soldier_Base_PMC {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Soldier_Engineer_PMC: Soldier_Base_PMC {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Soldier_Crew_PMC: Soldier_Base_PMC {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Soldier_Medic_PMC: Soldier_Base_PMC {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Soldier_TL_PMC: Soldier_Base_PMC {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Soldier_MG_PMC: Soldier_Base_PMC {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Soldier_Sniper_PMC: Soldier_Base_PMC {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Soldier_GL_PMC: Soldier_Base_PMC {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Soldier_Bodyguard_AA12_PMC: Soldier_Base_PMC {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Soldier_AA_PMC: Soldier_Base_PMC {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Soldier_AT_PMC: Soldier_Base_PMC {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Special_Character_Base_PMC: Soldier_Base_PMC { class EventHandlers; };
	class Poet_PMC: Special_Character_Base_PMC {
		class EventHandlers: EventHandlers { handleidentity = "true"; EXTENDED_EVENTHANDLERS };
	};
	class Ry_PMC: Special_Character_Base_PMC {
		class EventHandlers: EventHandlers { handleidentity = "true"; EXTENDED_EVENTHANDLERS };
	};
	class Reynolds_PMC: Special_Character_Base_PMC {
		class EventHandlers: EventHandlers { handleidentity = "true"; EXTENDED_EVENTHANDLERS };
	};
	class Tanny_PMC: Special_Character_Base_PMC {
		class EventHandlers: EventHandlers { handleidentity = "true"; EXTENDED_EVENTHANDLERS };
	};
	class Dixon_PMC: Special_Character_Base_PMC {
		class EventHandlers: EventHandlers { handleidentity = "true"; EXTENDED_EVENTHANDLERS };
	};

	// Custom object that can be used to force XEH initialization even if no XEH compatible object is on the Map.
	class Logic;
	class SLX_XEH_Logic: Logic {
		displayName = "XEH (backup) Initialization Logic";
		vehicleClass = "Modules";
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
};
