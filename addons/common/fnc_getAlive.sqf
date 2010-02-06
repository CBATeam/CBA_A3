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

private "_type";
_type = typeName _this;
if (_type in ["ARRAY","GROUP"]) exitwith {
	private ["_return","_array","_i"];
	_return = []; _i = 0;
	if (_type == "GROUP") then {_array = units _this} else {_array =+ _this};
	{
		if (alive _x) then {
			_return set [_i, _x];
			_i = _i + 1;
		}
	} ForEach _array;
	_return
};
alive _this