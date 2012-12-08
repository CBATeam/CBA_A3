/* ----------------------------------------------------------------------------
Function: CBA_fnc_isAlive

Description:
	A function used to find out if the group or object is alive.

Parameters:
	Array, Group or Unit

Example:
    (begin example)
	_alive = (Units player) call CBA_fnc_getAlive
    (end)

Returns:
	Boolean

Author:
	Rommel

---------------------------------------------------------------------------- */

private "_typename";
_typename = tolower(typename _this);

switch (_typename) do {
	case "array" : {
		{
			if (_x call CBA_fnc_isalive) exitwith {true};
			false;
		} foreach _this;
	};
	case "object" : {
		alive _this;
	};
	case "group" : {
		if (isnull (leader _this)) then {
			false;
		} else {
			(units _this) call CBA_fnc_isalive;
		};
	};
	default {alive _this};
};
