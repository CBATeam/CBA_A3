class CfgVehicles {
	class All {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class Static: All {
		XEH_DISABLED;
	};
	class Strategic;
	class ReammoBox: Strategic {
		XEH_ENABLED;
	};
	class Thing: All {
		XEH_DISABLED;
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

	// Custom object that can be used to force XEH initialization even if no XEH compatible object is on the Map.
	class Logic;
	class SLX_XEH_Logic: Logic {
		displayName = "XEH (backup) Initialization Logic";
		vehicleClass = "Modules";
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
};
