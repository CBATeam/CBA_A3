// Make event handler classes have the extended event handlers.
class CfgVehicles {
	class All {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
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
	class ParachuteBase: Helicopter {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	
	class Civilian_Base_H;
	class Pilot_Base_H: Civilian_Base_H { class EventHandlers; };
	class Pilot_Random_H: Pilot_Base_H {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Functionary_Base_H: Civilian_Base_H { class EventHandlers; };
	class Functionary_Random_H: Functionary_Base_H {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Citizen_Base_H: Civilian_Base_H { class EventHandlers; };
	class Citizen_Random_H: Citizen_Base_H {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Workman_Base_H: Civilian_Base_H { class EventHandlers; };
	class Workman_Random_H: Workman_Base_H {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class SeattleMan_Base_H: Civilian_Base_H { class EventHandlers; };
	class SeattleMan_Random_H: SeattleMan_Base_H {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Woman_Base_H;
	class Woman01_Base_H: Woman_Base_H { class EventHandlers; };
	class Woman01_Random_H: Woman01_Base_H {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Woman02_Base_H: Woman_Base_H { class EventHandlers; };
	class Woman02_Random_H: Woman02_Base_H {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Woman03_Base_H: Woman_Base_H { class EventHandlers; };
	class Woman03_Random_H: Woman03_Base_H {
		class EventHandlers: EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	
	class Helicopter_Base_H: Helicopter {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrier_Base_H;
	class FlagCarrier_USA_H: FlagCarrier_Base_H {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrier_Vrana_H: FlagCarrier_Base_H {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class FlagCarrier_Larkin_H: FlagCarrier_Base_H {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Target_Base_H;
	class Target_Person_PopUp_H: Target_Base_H {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Target_PopUp_H: Target_Base_H {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};


	// Custom object that can be used to force XEH initialization even if no XEH compatible object is on the Map.
	class Logic;
	class SLX_XEH_Logic: Logic {
		displayName = "XEH (backup) Initialization Logic";
		vehicleClass = "Modules";
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
};
