/* ----------------------------------------------------------------------------
Function: CBA_fnc_inArea

Description:
	A function used to determine if a position is within a zone.
Parameters:
	Marker, Object, Location, Group or Position, Zone (Marker, Trigger, Array)
Example:
	
Returns:
	Boolean
Author:
	Rommel

---------------------------------------------------------------------------- */
#include "script_component.hpp"

PARAMS_2(_position,_zRef);

_position = (_position call CBA_fnc_getpos);

private "_typeName";
_typeName = typeName _zRef;

private ["_zSize","_zDir","_zShape","_zPos"];
switch (_typeName) do {
	case ("STRING") : {
		_zSize = markerSize _zRef;
		_zDir = markerDir _zRef;
		_zShape = markerShape _zRef;
		_zPos = (_zRef call CBA_fnc_getpos);
	};
	case ("OBJECT") : {
		_zSize = triggerArea _zRef;
		_zDir = _zSize select 2;
		_zShape = if (_zSize select 3) then {"RECTANGLE"} else {"ELLIPSE"};
		_zPos = (_zRef call CBA_fnc_getpos);
	};
	case ("ARRAY") : {};
};

if (isnil "_zSize") exitwith {false};

_position = [_zPos,_position,_zDir] call CBA_fnc_vectRotate2D;

EXPLODE_2(_zPos,_x1,_y1);
EXPLODE_2(_position,_x2,_y2);

private ["_dx","_dy"];
_dx = _x2 - _x1;
_dy = _y2 - _y1;

EXPLODE_2(_zSize,_zx,_zy);

switch (_zShape) do {
	case ("ELLIPSE") : {
		((_dx^2)/(_zx^2) + (_dy^2)/(_zy^2)) < 1
	};
	case ("RECTANGLE") : {
		(abs _dx < _zx) and (abs _dy < _zy)
	};
};