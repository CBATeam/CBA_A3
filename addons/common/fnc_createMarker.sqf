/* ----------------------------------------------------------------------------
Function: CBA_fnc_createMarker

Description:
    Creates a marker all at once.

Parameters:
    _markerName - Name of marker to create [String]
    _position - [Array: [x, y]]
    _shape - "ICON", "RECTANGLE" or "ELLIPSE" [String]
    _size - [Array: [width, height]]

Optional Parameters:
    "GLOBAL" - Add for a global marker, but leave out for a local marker.
    "PERSIST" - Add for persisting global marker to JIP players. Implies "GLOBAL" when included.
    "BRUSH:" - e.g. "Solid"
    "COLOR:" - e.g. "ColorRed"
    "TEXT:" - e.g. "Objective Area"
    "TYPE:" - e.g. "Pickup"

Returns:
    Name of the marker [String]

Examples:
    (begin example)
        // simple marker creation
        _marker = ["markername", [positionX,positionY], "Rectangle", [sizeX, sizeY]] call CBA_fnc_createMarker;
        // Color yellow
        _marker = ["markername", [positionX,positionY], "Rectangle", [sizeX, sizeY], "COLOR:", "ColorYellow"] call CBA_fnc_createMarker;
        // Global marker - will be visible to all players currently ingame
        _marker = ["markername", [positionX,positionY], "Rectangle", [sizeX, sizeY], "COLOR:", "ColorYellow", "GLOBAL"] call CBA_fnc_createMarker;
        // Global persistent marker - will be visible to all players currently ingame, and also to JIP players
        _marker = ["markername", [positionX,positionY], "Rectangle", [sizeX, sizeY], "COLOR:", "ColorYellow", "PERSIST"] call CBA_fnc_createMarker;
    (end)

Author:
    Sickboy (sb_at_dev-heaven.net) 6thSense.eu Mod
---------------------------------------------------------------------------- */
// #define DEBUG_MODE_FULL
#include "script_component.hpp"
SCRIPT(createMarker);

private ["_m", "_br", "_ty", "_co", "_tx", "_persist", "_global"];

_br = ["BRUSH:", "brush:", "", _this] call CBA_fnc_getArg;
_ty = ["TYPE:", "type:", "", _this] call CBA_fnc_getArg;
_co = ["COLOR:", "color:", "", _this] call CBA_fnc_getArg;
_tx = ["TEXT:", "text:", "", _this] call CBA_fnc_getArg;
_persist = "PERSIST" in _this;
_global = "GLOBAL" in _this || _persist;
TRACE_6("",_br,_ty,_co,_tx,_persist,_global);


if (_global) then {
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

_m;
