/*
Function: CBA_fnc_getMarkerPersistent

Description:
	Checks if a global marker is persistent for JIP players.

	Always returns false unless called on the server.
	
	Set/unset persistency with <CBA_fnc_setMarkerPersistent>.
	
Parameters:
	_marker - Name of a marker [String]

Returns:
	True if the marker is persistent. False if not persistent or if executed 
		on a dedicated client [Boolean]
	
Example:
	(begin example)
		_isPersistent = ["TAG_fishingVillage"] call CBA_fnc_getMarkerPersistent;
	(end)
	
Author:
	Spooner
*/
#include "script_component.hpp"

PARAMS_1(_marker);
TRACE_1(_this);

private ["_markerConsistent", "_return"];
_markerConsistent = toLower _marker; // Ensure we use a consistent name to search for.

_return = if (SLX_XEH_MACHINE select 3) then
{
	_markerConsistent in GVAR(MARKERS);
} else {
	WARNING("Function ran on a dedicated client. Function only usable on a server for marker: " + str _marker);
	false;
};

_return;
