/*
Function: CBA_fnc_addPersistentMarker

Description:
	Makes a global marker persistent for JIP players.
*/
#include "script_component.hpp"

PARAMS_1(_marker);
TRACE_1(_this);

if (isServer) then
{
	if (_marker in GVAR(MARKERS)) then
	{
		WARNING("Marker already persistent " + str(_marker));
	} else {
		PUSH(GVAR(MARKERS),_marker);
	};
	true;
} else {
	WARNING("Function ran on a dedicated client. Function only usable on a server");
	false;
};
