#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = { QUOTE(MAIN_ADDON) };
	};
};

// PRELOAD_ADDONS;

// #include "CfgEventhandlers.hpp"
// #include "CfgVehicles.hpp"
