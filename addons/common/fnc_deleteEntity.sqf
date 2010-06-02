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

#include <script_component.hpp>

private "_typeName";
_typeName = typeName _this;

switch (_typeName) do {
	case ("ARRAY") : {
		{
			_x call CBA_fnc_deleteEntity;
		} foreach _this;
	};
	case ("OBJECT") : {
		if (vehicle _this != _this) then {
			unassignVehicle _this;
			_this setposasl [0,0,0];
		};
		deletevehicle _this;
	};
	case ("GROUP") : {
		(units _this) call CBA_fnc_deleteEntity;
		{deletewaypoint _x} foreach (waypoints _this);
		deletegroup _this;
	};
	case ("LOCATION") : {
		deleteLocation _this;
	};
	case ("STRING") : {
		deleteMarker _this
	};
	default {deletevehicle _this};
};
