/*
Function: CBA_fnc_removePersistentMarker

Description:
	Removes the persistency of a global marker for JIP players.
*/
#include "script_component.hpp"

if (isServer) then
{
	if (_this in GVAR(MARKERS)) then
	{
		SUB(GVAR(MARKERS),_this);
	} else {
		WARNING("Marker was already not persistent " + str(_this));
	};
	true;
} else {
	false;
};
