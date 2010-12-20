#include "script_component.hpp"

// Detect new units and check if XEH is enabled on them
while {true} do {
	SLX_XEH_PROCESSED_OBJECTS = SLX_XEH_PROCESSED_OBJECTS - [objNull]; // cleanup
	{ if !(isNull _x) then { [_x] call SLX_XEH_FNC_SUPPORTM } } forEach ((vehicles+allUnits) - SLX_XEH_PROCESSED_OBJECTS); // TODO: Does this need an isNull check?
	sleep 2;
};
