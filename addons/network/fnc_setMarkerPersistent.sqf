/*
Function: CBA_fnc_setMarkerPersistent

Description:
	Sets or unsets JIP persistency on a global marker.

	Only has an	effect if called on the server.

	Query persistency with <CBA_fnc_getMarkerPersistent>.

Parameters:
	_marker - Name of a marker [String]
	_persistent - If true, marker will be kept consistent for JIP players [Boolean]

Returns:
	True if executed on the server [Boolean]

Example:
	(begin example)
		_marker = createMarker ["TAG_fishingVillage", getPos TAG_fish];
		[_marker, true] call CBA_fnc_setMarkerPersistent.
		// Marker will be kept persistent for JIP players.
		// later...
		["TAG_fishingVillage", false] call CBA_fnc_setMarkerPersistent.
		// Marker will no longer be kept persistent for JIP players.
	(end)

Author:
	Sickboy
*/
#include "script_component.hpp"

PARAMS_2(_marker,_persistent);
TRACE_1(_this);

private ["_markerConsistent", "_return"];
_markerConsistent = toLower _marker; // Name of marker as stored internally.

_return = if (SLX_XEH_MACHINE select 3) then
{
	if (_persistent) then
	{
		if (_markerConsistent in GVAR(MARKERS)) then
		{
			WARNING("Marker already persistent: " + str _marker);
		} else {
			PUSH(GVAR(MARKERS),_markerConsistent);
		};
	} else {
		if (_markerConsistent in GVAR(MARKERS)) then
		{
			SUB(GVAR(MARKERS),[_markerConsistent]);
		} else {
			WARNING("Marker was already not persistent: " + str _marker);
		};
	};
	true;
} else {
	WARNING("Function ran on a dedicated client. Function only usable on a server. Marker was: " + str _marker);
	false;
};

_return;
