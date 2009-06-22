#include "script_component.hpp"
// 6thSense.eu Mod - fCreateMarker - by Sickboy (sb_at_dev-heaven.net)
// Usage:
//		_marker = ["markername", [positionX,positionY], "Shape", [sizeX,sizeY]] call CBA_fCreateMarker;
// Shape can be: Icon, Rectangle and Elipse
// Optional Parameters:
// "BRUSH:", "Solid"
// "COLOR:", "ColorRed"
// "TEXT:", "Objective Area"
// "TYPE:", "Pickup"
// "GLOBAL"
private ["_m", "_br", "_ty", "_co", "_tx"];

_br = ["BRUSH:", "brush:", "", _this] call CBA_fGetArg;
_ty = ["TYPE:", "type:", "", _this] call CBA_fGetArg;
_co = ["COLOR:", "color:", "", _this] call CBA_fGetArg;
_tx = ["TEXT:", "text:", "", _this] call CBA_fGetArg;

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