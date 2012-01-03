// #define DEBUG_MODE_FULL
#include "script_component.hpp"

// Detect new units and check if XEH is enabled on them
while {true} do {
	TRACE_3("SupportMonitor Loop", count SLX_XEH_PROCESSED_OBJECTS, count vehicles, count allUnits);
	SLX_XEH_PROCESSED_OBJECTS = SLX_XEH_PROCESSED_OBJECTS - [objNull]; // cleanup
	{
		if !(isNull _x) then {
			PUSH(SLX_XEH_PROCESSED_OBJECTS,_x);
			[_x] call FUNC(support_monitor);
		};
	} forEach ((vehicles+allUnits) - SLX_XEH_PROCESSED_OBJECTS); // TODO: Does this need an isNull check?
	sleep 3;
};
