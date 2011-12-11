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

#include "script_component.hpp"

private "_typename";
_typename = tolower (typename _this);
if (_typename == "object") exitwith {alive _this};

private ["_return","_array"];
_array = [];
switch (_typename) do {
	case ("group") : {
		_array = units _this;
	};
	case ("array") :{
		_array =+ _this;
	};
};

_return = [];
{
	if (alive _x) then {
		PUSH(_return,_x);
	}
} foreach _array;
_return