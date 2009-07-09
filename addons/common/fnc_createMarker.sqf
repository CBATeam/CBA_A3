/* ----------------------------------------------------------------------------
Function: CBA_fnc_createMarker

Description:
	Creates a marker all at once.
	
Parameters:
	_markerName - Name of marker to create [String]
	_position - [Array: [x, y]]
	_shape - "Icon", "Rectangle" or "Elipse" [String]
	_size - [Array: [width, height]]
	
Optional Parameters:
	"BRUSH:" - e.g. "Solid"
	"COLOR:" - e.g. "ColorRed"
	"TEXT:" - e.g. "Objective Area"
	"TYPE:" - e.g. "Pickup"
	"GLOBAL" - Add for a global marker, but leave out for a local marker. 

Returns:
	Name of the marker [String]
	
Examples:
	(begin example)
		_marker = ["markername", [positionX,positionY], "Rectangle", [sizeX, sizeY]] call CBA_fnc_CreateMarker;
	(end)

Author:
	Sickboy (sb_at_dev-heaven.net) 6thSense.eu Mod
---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(createMarker);

private ["_m", "_br", "_ty", "_co", "_tx"];

_br = ["BRUSH:", "brush:", "", _this] call CBA_fnc_GetArg;
_ty = ["TYPE:", "type:", "", _this] call CBA_fnc_GetArg;
_co = ["COLOR:", "color:", "", _this] call CBA_fnc_GetArg;
_tx = ["TEXT:", "text:", "", _this] call CBA_fnc_GetArg;

if ("GLOBAL" in _this) then
{
	_m = createMarker [_this select 0, _this select 1];
	_m setMarkerShape (_this select 2);
	_m setMarkerSize (_this select 3);
	if (_br!= "") then { _m setMarkerBrush _br };
	if (_ty!= "") then { _m setMarkerType _ty };
	if (_co!= "") then { _m setMarkerColor _co };
	if (_tx!= "") then { _m setMarkerText _tx };
} else {
	_m = createMarkerLocal [_this select 0, _this select 1];
	_m setMarkerShapeLocal (_this select 2);
	_m setMarkerSizeLocal (_this select 3);
	if (_br!= "") then { _m setMarkerBrushLocal _br };
	if (_ty!= "") then { _m setMarkerTypeLocal _ty };
	if (_co!= "") then { _m setMarkerColorLocal _co };
	if (_tx!= "") then { _m setMarkerTextLocal _tx };
};
_m
