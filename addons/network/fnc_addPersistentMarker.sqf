/*
Function: CBA_fnc_addPersistentMarker

Description:
	Makes a global marker persistent for JIP players.
*/
#include "script_component.hpp"

if (isServer) then
{
	if (_this in GVAR(MARKERS)) then
	{
		WARNING("Marker already persistent " + str(_this));
	} else {
		PUSH(GVAR(MARKERS),_this);
	};
	true;
} else {
	false;
};
