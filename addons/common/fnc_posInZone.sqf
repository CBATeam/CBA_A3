/* ----------------------------------------------------------------------------
Function: CBA_fnc_posInZone

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
DEFAULT_PARAM(2,_zPosition,_zRef);

_position = _position call cba_fnc_getpos;
_zPosition = _zPosition call cba_fnc_getpos;

private "_typeName";
_typeName = typeName _zone;

private ["_zSize","_zDir","_zShape"];

switch (_typeName) do {
	case ("STRING") : {
		_zSize = markerSize _zRef;
		_zDir = markerDir _zRef;
		_zShape = markerShape _zRef;
	};
	case ("OBJECT") : {
		_zSize = triggerArea _zRef;
		_zDir = _zSize select 2;
		_zShape = if (_zSize select 3) then {"RECTANGLE"} else {"ELLIPSE"};
	};
	default {false};
};

_position = [_zPosition,_position,_zDir] call cba_fnc_vectRotate;

EXPLODE_2(_zSize,_zx,_zy);

private "_return";
_return = 0;

switch (_zShape) do {
	case ("ELLIPSE") : {
		private "_distance";
		_distance = _position distance _zPosition;
		if (_distance < (_zx min _zy)) exitwith {_return = 2};
		private ["_dx","_dy","_a"];
		_dx = ARG_1(_position,0) - ARG_1(_zPosition,0);
		_dy = ARG_1(_position,1) - ARG_1(_zPosition,1);
		_a = _dx atan2 _dy;
		if (_dx * cos(_a) < _zx) then {INC(_return)};
		if (_dy * sin(_a) < _zy) then {INC(_return)};
	};
	case ("RECTANGLE") : {
		private ["_dx","_dy"];
		_dx = ARG_1(_position,0) - ARG_1(_zPosition,0);
		_dy = ARG_1(_position,1) - ARG_1(_zPosition,1);
		if (abs _dx < _zx) then {INC(_return)};
		if (abs _dy < _zy) then {INC(_return)};
	};
};

if (_return == 2) then {true} else {false};
