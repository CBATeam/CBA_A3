/* ----------------------------------------------------------------------------
Function: CBA_fnc_getPos

Description:
	A function used to get the position of an entity.
Parameters:
	Marker, Object, Location, Group or Position
Example:
	_position = (group player) call CBA_fnc_getPos
Returns:
	Position (AGL) - [X,Y,Z]
Author:
	Rommel

---------------------------------------------------------------------------- */
#include "script_component.hpp"

private "_typeName";
_typeName = typeName _this;

switch (_typeName) do {
	case ("OBJECT") : {
		private "_position";
		_position = getposATL _this;
		if (surfaceIsWater _position) then {
			_position = getposASL _this
		};
		_position
	};
	case ("GROUP") : {
		private ["_units", "_count", "_tx", "_ty", "_tz"];
		_units = (units _this) call FUNCMAIN(getAlive);
		_count = count _units;
		if (_count < 2) exitwith {(leader _this) call FUNCMAIN(getPos)};
		_tx = 0; _ty = 0; _tz = 0;
		{
			private "_position";
			_position = _x call FUNCMAIN(getPos);
			_tx = _tx + (_position select 0);
			_ty = _ty + (_position select 1);
			_tz = _tz + (_position select 2);
		} foreach _units;
		_tx = _tx / _count;
		_ty = _ty / _count;
		_tz = _tz / _count;
		[_tx, _ty, _tz]
	};
	case ("STRING") : {
		getMarkerPos _this
	};
	case ("LOCATION") : {
		position _this
	};
	case ("TASK") : {
		taskDestination _this
	};
	default {_this};
};