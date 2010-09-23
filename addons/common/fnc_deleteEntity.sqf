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
			_x call CBA_fnc_deletEentity;
		} foreach _this;
	};
	case ("object") : {
		if (vehicle _this != _this) then {
			unassignvehicle _this;
			_this setposasl [0,0,0];
		};
		deletevehicle _this;
	};
	case ("group") : {
		(units _this) call CBA_fnc_deleteEntity;
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
