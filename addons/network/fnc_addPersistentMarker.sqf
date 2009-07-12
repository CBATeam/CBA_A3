/*
Internal Function: CBA_fnc_addPersistentMarker
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
