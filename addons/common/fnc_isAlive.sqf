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

private "_typeName";
_typeName = typeName _this;

switch (_typeName) do {
	case ("ARRAY") : {
		{
			if (_x call FUNCMAIN(isAlive)) exitwith {true};
			false;
		} foreach _this;
	};
	case ("OBJECT") : {
		alive _this;
	};
	case ("GROUP") : {
		(units _this) call FUNCMAIN(isAlive);
	};
	default {alive _this};
};