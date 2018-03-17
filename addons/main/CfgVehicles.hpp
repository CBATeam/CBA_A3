// Add a game logic which does nothing except requires the addon in the mission.

class CfgVehicles {
    class Logic;
    class CBA_main_require: Logic {
        displayName = "Require CBA";
        vehicleClass = "Modules";
    };
};
