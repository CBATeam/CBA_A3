/* ----------------------------------------------------------------------------
Function: CBA_fnc_setPos

Description:
A function used to set the position of an entity.
Parameters:
Marker, Object, Location, Group or Position
Example:
[player, "respawn_west"] call CBA_fnc_setPos
Returns:
Nil
Author:
Rommel

---------------------------------------------------------------------------- */

#include <script_component.hpp>

PARAMS_2(_entity,_position);
DEFAULT_PARAM(2,_radius,0);

private "_typename";
_typename = tolower (typename _entity);
_position = _position call RMM_fnc_getpos;

if (_radius > 0) then {
	_position = [_position, _radius] call CBA_fnc_randPos;
};

switch (_typename) do {
	case ("object") : {
		_entity setpos _position;
	};
	case ("group") : {
		_position = getpos (leader _entity);
		_x = (_position select 0);
		_y = (_position select 1);
		_z = (_position select 2);
		{
			private ["_txyz","_tx", "_ty", "_tz"];
			_txyz = (_x worldtomodel _position);
			_tx = _x + (_txyz select 0);
			_ty = _y + (_txyz select 1);
			_tz = _z + (_txyz select 2);
			_x setpos [_tx,_ty,_tz];
		} foreach (units _entity);
	};
	case ("string") : {
		_entity setmarkerpos _position;
	};
	case ("location") : {
		if (surfaceiswater _position) then {
			_entity setPosition _position;
		} else {
			_entity setPosition _position;
		};
	};
	case ("task") : {
		_entity setsimpletaskdestination _position;
	};
	default {_entity setpos _position};
};
