#ifndef CBA_MAIN_CFG_VEHICLES_INCLUDED
#define CBA_MAIN_CFG_VEHICLES_INCLUDED

// Add a game logic which does nothing except requires the addon in the mission.
class CfgVehicleClasses
{
	class ADDON
	{
		displayName = QUOTE(PREFIX);
	};
};

class CfgVehicles
{
	class Logic;
	
	class CBA_main_require : Logic
	{
		displayName = QUOTE(Require PREFIX);
		vehicleClass = QUOTE(ADDON);
	};
};

#endif // CBA_MAIN_CFG_VEHICLES_INCLUDED
