/* ----------------------------------------------------------------------------
Function: CBA_fnc_isAlive

Description:
	A function used to find out if the group or object is alive.
Parameters:
	Array, Group or Unit
Example:
	_alive = (Units player) call CBA_fnc_getAlive
Returns:
	Boolean
Author:
	Rommel

---------------------------------------------------------------------------- */

private "_type";
_type = typeName _this;
if (_type in ["ARRAY","GROUP"]) exitwith {
	private "_array";
	if (_type == "GROUP") then {_array = units _this} else {_array =+ _this};
	{if (Alive _x) exitwith {true}; false} ForEach _array;
};
alive _this