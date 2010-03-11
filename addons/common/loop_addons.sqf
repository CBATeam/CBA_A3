// #define DEBUG_MODE_FULL
#include "script_component.hpp"

private ["_cfg", "_c", "_addons"];

// Find and Count CfgPatches
_cfg = (configFile >> "CfgPatches");
_c = count _cfg;
if (_c == 0) exitWith {
	WARNING("Somehow No Addons found to Activate");
};

// Process all CfgPatches
_addons = [];
for "_i" from 0 to (_c - 1) do {
	_entry = _cfg select _i;
	if (isClass _entry) then {
		PUSH(_addons,configName _entry);
	};
};

// Activate all CfgPatches
activateAddons _addons;
TRACE_1("Activated",count _addons);

sleep 0.001;
if (SLX_XEH_MACHINE select 1) then { sleep 0.001 }; // JIP

while {true} do {
	activateAddons _addons;
	sleep 5; // Experimental
};
