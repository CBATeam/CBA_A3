/* ----------------------------------------------------------------------------
Function: CBA_fnc_getAlive

Description:
	A function used to find out who is alive in an array or a group.
Parameters:
	Array, Group or Unit
Example:
	_alive = (Units player) call CBA_fnc_getAlive
Returns:
	Array
Author:
	Rommel

---------------------------------------------------------------------------- */

private "_typeName";
_typeName = typeName _this;
if (_typeName == "OBJECT") exitwith {alive _this};

private ["_return","_array"];
_array = [];
switch (_typeName) do {
	case ("GROUP") : {
		_array = units _this;
	};
	case ("ARRAY") :{
		_array =+ _this;
	};
};
{
	if (alive _x) then {
		_return set [count _return, _x];
	}
} ForEach _array;
_return