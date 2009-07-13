/*
Function: CBA_fnc_removePersistentMarker

Description:
	Removes the persistency of a global marker for JIP players.

*/
#include "script_component.hpp"

PARAMS_1(_marker);
TRACE_1(_this);

if (isServer) then
{
	if (_marker in GVAR(MARKERS)) then
	{
		SUB(GVAR(MARKERS),[_marker]);
	} else {
		WARNING("Marker was already not persistent " + str(_marker));
	};
	true;
} else {
	WARNING("Function ran on a dedicated client. Function only usable on a server");
	false;
};
