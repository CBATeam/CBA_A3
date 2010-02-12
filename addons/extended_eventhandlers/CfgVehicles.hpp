// Make event handler classes have the extended event handlers.
class CfgVehicles
{
	class All;
	class Air;
	class Animal;
	class LandVehicle;
	class Man;
	class Tracked_APC;
	class StaticWeapon;
	
	// Generic classes.
	class AllVehicles: All
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	/*
	class CAAnimalBase: Animal
	{
		 class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	*/
	class CAManBase: Man
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Car: LandVehicle
	{
		class EventHandlers : DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class Helicopter: Air
	{
		class EventHandlers : DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class Plane: Air
	{
		class EventHandlers : DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
	};
	/*
	class ParachuteBase: Helicopter
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	*/
	class Ship: AllVehicles
	{
		class EventHandlers : DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class StaticCannon: StaticWeapon
	{
		 class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Tank: LandVehicle
	{
		class EventHandlers : DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
	};
	
	// Vehicles.
	/*
	class BIS_Steerable_Parachute : Plane
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	*/
	class AAV: Tracked_APC
	{
		 class EventHandlers : DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class A10 : Plane
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Su34 : Plane
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	/*
	class MQ9PredatorB;
	class CruiseMissile2 : MQ9PredatorB
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	*/
	
	// Static weapons.
	class StaticMortar;
	class 2b14_82mm : StaticMortar
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class M252 : StaticMortar
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	
	// Fires.
	class Land_Fire;
	class Land_Fire_burning : Land_Fire
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	
	class Land_Campfire;
	class Land_Campfire_burning : Land_Campfire
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	
	class Land_Fire_barrel;
	class Land_Fire_barrel_burning : Land_Fire_barrel
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	
	// Flag carriers
	class FlagCarrier;
	class FlagCarrierUSA : FlagCarrier
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierCDF : FlagCarrierUSA
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierRU : FlagCarrierUSA
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierINS : FlagCarrierUSA
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrierGUE : FlagCarrierUSA
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	
	class FlagCarrierCore;
	class FlagCarrierChecked : FlagCarrierCore
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	
	// Popup targets
	class TargetBase;
	class TargetPopUpTarget : TargetBase
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class TargetEpopup : TargetBase
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	
	// Buildings
	class Land_Barrack2;
	class Barrack2 : Land_Barrack2
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	
	class Grave;
	class Mass_grave : Grave
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	
	// Logics
	class Logic;
	class BIS_ARTY_Logic : Logic
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class BIS_ARTY_Virtual_Artillery : Logic
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Warfare : Logic
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class AlternativeInjurySimulation : Logic
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class AliceManager : Logic
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class AmbientCombatManager : Logic
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class BIS_animals_Logic : Logic
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class BattleFieldClearance : Logic
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class BIS_clouds_Logic : Logic
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class ConstructionManager : Logic
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FirstAidSystem : Logic
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FunctionsManager : Logic
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class PreloadManager : Logic
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class GarbageCollector : Logic
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class HighCommand : Logic
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class MartaManager : Logic
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class SilvieManager : Logic
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class BIS_SRRS_Logic : Logic
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class UAVManager : Logic
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class ZoraManager : Logic
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class SecOpManager : Logic
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class StrategicReferenceLayer : Logic
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	
	// Force Recon specials:
#define SLX_BIS_ForceRecon_EH \
	{ \
		class EventHandlers : EventHandlers \
		{ \
			HandleIdentity = "true"; \
			EXTENDED_EVENTHANDLERS \
		}; \
	}
	
	class SoldierWB;
	class FR_Base : SoldierWB
	{
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	
	class FR_Miles : FR_Base
	SLX_BIS_ForceRecon_EH;

	class FR_GL : FR_Base
	{
		class EventHandlers;
	};
	class FR_Cooper : FR_GL
	SLX_BIS_ForceRecon_EH;

	class FR_Marksman : FR_Base
	{
		class EventHandlers;
	};
	class FR_Sykes : FR_Marksman
	SLX_BIS_ForceRecon_EH;

	class FR_Corpsman : FR_Base
	{ 
		class EventHandlers;
	};
	class FR_OHara : FR_Corpsman
	SLX_BIS_ForceRecon_EH;

	class FR_AR : FR_Base 
	{ 
		class EventHandlers;
	};
	class FR_Rodriguez : FR_AR
	SLX_BIS_ForceRecon_EH;
};
