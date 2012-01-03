// #define DEBUG_MODE_FULL
#include "script_component.hpp"

_fnc = {
	if !(_this getVariable SLX_XEH_AR_FALSE) then {
		_this setVariable SLX_XEH_AR_TRUE;
		_this call FUNC(support_monitor);
	};
};

// Detect new units and check if XEH is enabled on them
while {true} do {
	TRACE_2("SupportMonitor Loop", count vehicles, count allUnits);

	{ _x call _fnc } forEach vehicles;
	{ _x call _fnc } forEach allUnits;

	sleep 3;
};
