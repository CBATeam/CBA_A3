class CfgVehicles {
	class All {
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
	class ArtilleryTarget: All {
		XEH_DISABLED;
	};
	class FireSectorTarget: All {
		XEH_DISABLED;
	};
	class LaserTarget: All  {
		XEH_DISABLED;
	};
	class NVTarget: All  {
		XEH_DISABLED;
	};
	class Static: All {
		XEH_DISABLED;
	};
	class Thing: All {
		XEH_DISABLED;
	};

	class Strategic;
	class ReammoBox: Strategic {
		XEH_ENABLED;
	};

	class Air;
	class Helicopter: Air {
		class Eventhandlers: DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
	};
	class ParachuteBase: Helicopter {
		XEH_DISABLED;
	};
	class Plane: Air {
		class Eventhandlers: DefaultEventhandlers { EXTENDED_EVENTHANDLERS };
	};

	class StaticWeapon;
	class StaticCannon: StaticWeapon {
		class Eventhandlers { EXTENDED_EVENTHANDLERS };
	};

	// Custom object that can be used to force XEH initialization even if no XEH compatible object is on the Map.
	class Logic;
	class SLX_XEH_Logic: Logic {
		displayName = "XEH (backup) Initialization Logic";
		vehicleClass = "Modules";
		class EventHandlers { EXTENDED_EVENTHANDLERS };
	};
};
