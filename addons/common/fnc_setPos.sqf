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

private ["_entity","_position","_radius"];
_entity = _this select 0;
_position = _this select 1;
_radius = if (count _this > 2) then {_this select 2} else {0};

private "_typename";
_typename = tolower (typename _entity);
_position = _position call CBA_fnc_getpos;

if (_radius > 0) then {
	_position = [_position, _radius] call CBA_fnc_randPos;
};

switch (_typename) do {
	case ("object") : {
		_entity setpos _position;
	};
	case ("group") : {
		private ["_ldp","_dx","_dy","_dz"];
		_ldp = getpos (leader _entity);
		_dx = _position select 0;
		_dy = _position select 1;
		_dz = _position select 2;
		{
			private ["_txyz","_tx", "_ty", "_tz"];
			_txyz = _x worldtomodel _ldp;
			_tx = _dx + (_txyz select 0);
			_ty = _dy + (_txyz select 1);
			_tz = _dz + (_txyz select 2);
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
