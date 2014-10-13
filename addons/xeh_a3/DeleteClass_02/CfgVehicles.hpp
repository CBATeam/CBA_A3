class CfgVehicles {
	class Car_F;
	class Civilian_F;
	class Helicopter;
	class Offroad_01_base_F;
	class Ship_F;
	class Truck_F;


	class C_man_1: Civilian_F {
		delete Eventhandlers; // Eventhandlers
	};
	class Helicopter_Base_F: Helicopter {
		delete Eventhandlers; // Eventhandlers
	};
	class Boat_Civil_01_base_F: Ship_F {
		delete Eventhandlers; // Eventhandlers
	};
	class Offroad_01_repair_base_F: Offroad_01_base_F {
		delete Eventhandlers; // Eventhandlers
	};
	class Quadbike_01_base_F: Car_F {
		delete Eventhandlers; // Eventhandlers
	};
	class Van_01_base_F: Truck_F {
		delete Eventhandlers; // Eventhandlers
	};
};
