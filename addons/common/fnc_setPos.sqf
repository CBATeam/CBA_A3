/* ----------------------------------------------------------------------------
Function: CBA_fnc_setPos

Description:
A function used to set the position of an entity.
Parameters:
Marker, Object, Location, Group or Position
Example:
[player, "respawn_west" call CBA_fnc_getPos] call CBA_fnc_setPos
Returns:
Nil
Author:
Rommel

---------------------------------------------------------------------------- */

#include <script_component.hpp>

PARAMS_2(_entity,_position);
DEFAULT_PARAM(2,_radius,0);

private "_typeName";
_typeName = typeName _entity;
_position = (_position call CBA_fnc_getpos);

if (_radius > 0) then {
	_radius = _radius * 2;
	_position = [
		(_position select 0) + ((random _radius) - (random _radius)),
		(_position select 1) + ((random _radius) - (random _radius)),
		(_position select 2)
	];
};

switch (_typeName) do {
	case ("OBJECT") : {
		if (surfaceIsWater _position) then {
			_entity setposASL _position;
		} else {
			_entity setposATL _position;
		};
	};
	case ("GROUP") : {
		_position = (leader _this) call CBA_fnc_getpos;
		_x = (_position select 0);
		_y = (_position select 1);
		_z = (_position select 2);
		{
			private ["_txyz","_tx", "_ty", "_tz"];
			_txyz = (_x worldToModel _position);
			_tx = _x + (_txyz select 0);
			_ty = _y + (_txyz select 1);
			_tz = _z + (_txyz select 2);
			[_x,[_tx,_ty,_tz]] call CBA_fnc_setpos;
		} foreach (units _this);
	};
	case ("STRING") : {
		_entity setMarkerPos _position;
	};
	case ("LOCATION") : {
		if (surfaceIsWater _position) then {
			_entity setposASL _position;
		} else {
			_entity setposATL _position;
		};
	};
	case ("TASK") : {
		_entity setSimpleTaskDestination _position;
	};
	default {_entity setpos _position};
};
