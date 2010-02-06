/* ----------------------------------------------------------------------------
Function: CBA_fnc_taskDefend

Description:
	A function for a group to defend a parsed location. Groups will mount nearby static machine guns, and bunker in nearby buildings. They will also patrol the radius.
Parameters:
	- Group (Group or Object)
	- Position (XYZ, Object, Location or Group)
	Optional:
	- Defend Radius (Scalar)
Example:
	[group player, player] call CBA_fnc_taskDefend
Returns:
	Nil
Author:
	Rommel

---------------------------------------------------------------------------- */

#include "\x\cba\addons\main\script_macros_common.hpp"

#define ARG2(X,Y)	((X) select (Y))

private ["_count", "_waypoints", "_list", "_units", "_i"];

PARAMS_2(_group,_position);
_group = _group call CBA_fnc_getGroup;
DEFAULT_PARAM(2,_radius,50);

_group enableAttack false;
_list = [_position, vehicles, _radius, {(_x isKindOf "LandVehicles") && (_x emptyPositions "gunner" > 0)}] call CBA_fnc_getNearest;
_count = count _list;
_units = units _group;
_i = 0;
{
	if (random 1 < 0.34) then {
		if (_count > 0) then {
			_x assignAsGunner ARG2(_list,(_count - 1));
			_list resize (_count - 1);
			[_x] orderGetIn true;
			INC(_i);
		};
	} else {
		if (random 1 < 0.67) then {
			private ["_array", "_building", "_count"];
			_array = _x call CBA_fnc_getNearestBuilding;
			_building = ARG2(_array, 0);
			if (([_x,_building] call CBA_fnc_getDistance) < _radius) then {
				_count = ARG2(_array, 1);
				_x commandMove (_building buildingPos _count);
				_x spawn {
					waituntil {unitReady _this}; 
					commandStop _this;
				};
			};
			INC(_i);
		};
	};
} forEach _units;
_count = count _units;
if (_i < _count * 0.75) exitwith {
	[_group, _position, _radius/2 * _count, 5, "SAD", "SAFE", "YELLOW", "LIMITED"] call CBA_fnc_taskPatrol;
};