/* ----------------------------------------------------------------------------
Function: CBA_fnc_getPos

Description:
	A function used to get the position of an entity.

Parameters:
	Marker, Object, Location, Group or Position

Example:
    (begin example)
	_position = (group player) call CBA_fnc_getPos
    (end)

Returns:
	Position (AGL) - [X,Y,Z]

Author:
	Rommel

---------------------------------------------------------------------------- */

private "_typename";

_typename = tolower (typename _this);

switch (_typename) do {
	case "object" : {
		getpos _this
	};
	case "group" : {
		getpos (leader _this)
	};
	case "string" : {
		getmarkerpos _this
	};
	case "location" : {
		position _this
	};
	case "task" : {
		taskdestination _this
	};
	default {_this};
};
