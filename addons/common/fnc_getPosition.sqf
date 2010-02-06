/* ----------------------------------------------------------------------------
Function: CBA_fnc_getPosition

Description:
	A function used to position of an entity.
Parameters:
	Marker, Object, Location, Group or Position
Example:
	_position = (group player) call CBA_fnc_getPosition
Returns:
	Position (ASL) - [X,Y,Z]
Author:
	Rommel

---------------------------------------------------------------------------- */

private "_typeName";
_typeName = typeName _this;
if (_typeName == "STRING") exitwith {
	getMarkerPos _this
};
if (_typeName == "ARRAY") exitwith {
	if ((count _this) in [2,3]) then {
		_this
	};
};
if (_typeName == "OBJECT") exitwith {getposASL _this};
if (_typeName == "LOCATION") exitWith {position _this};

if (_typeName == "GROUP") exitwith {
	private ["_units", "_count", "_tx", "_ty", "_tz"];
	_units = (units _this) call CBA_fnc_getAlive;
	_count = count _units;
	if (_count < 2) exitwith {getposASL (leader _this)};
	_tx = 0; _ty = 0; _tz = 0;
	{
		private "_position";
		_position = getPosASL _x;
		_tx = _tx + (_position select 0);
		_ty = _ty + (_position select 1);
		_tz = _tz + (_position select 2);
	} foreach _units;
	_tx = _tx / _count;
	_ty = _ty / _count;
	_tz = _tz / _count;
	[_tx, _ty, _tz]
};