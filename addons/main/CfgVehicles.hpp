// Add a game logic which does nothing except requires the addon in the mission.

#define VEHICLE_TYPE PREFIX##_logics
#define LOGIC_CLASS ADDON##_main_require

class CfgVehicleClasses
{
	class VEHICLE_TYPE
	{
		displayName = "CBA";
	};
};

class CfgVehicles
{
	class Logic;
	
	class LOGIC_CLASS : Logic
	{
		displayName = "Require CBA";
		vehicleClass = VEHICLE_TYPE;
	};
};
