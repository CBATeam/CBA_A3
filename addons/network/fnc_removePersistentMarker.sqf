/*
Function: CBA_fnc_removePersistentMarker
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
