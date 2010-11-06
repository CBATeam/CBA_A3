/* ----------------------------------------------------------------------------
Function: CBA_fnc_deleteEntity

Description:
	A function used to delete entities
Parameters:
	Array, Object, Group or Marker
Example:
	[car1,car2,car3] call CBA_fnc_deleteEntity
Returns:
	Nothing
Author:
	Rommel

---------------------------------------------------------------------------- */

private "_typename";
_typename = tolower (typename _this);

switch (_typename) do {
	case ("array") : {
		{
			_x call CBA_fnc_deleteentity;
		} foreach _this;
	};
	case ("object") : {
		if (vehicle _this != _this) then {
			unassignvehicle _this;
			_this setposasl [0,0,0];
		};
		if (count ((crew _this)-[_this]) > 0) then {
			(crew _this) call CBA_fnc_deleteentity;
		};
		deletevehicle _this;
	};
	case ("group") : {
		(units _this) call CBA_fnc_deleteentity;
		{deletewaypoint _x} foreach (waypoints _this);
		deletegroup _this;
	};
	case ("location") : {
		deletelocation _this;
	};
	case ("string") : {
		deletemarker _this
	};
	default {deletevehicle _this};
};
