// Add a game logic which does nothing except requires the addon in the mission.

class CfgVehicleClasses
{
	class CBA_logics
	{
		displayName = "CBA";
	};
};

class CfgVehicles
{
	class Logic;
	
	class CBA_main_require : Logic
	{
		displayName = "Require CBA";
		vehicleClass = "CBA_logics";
	};
};
