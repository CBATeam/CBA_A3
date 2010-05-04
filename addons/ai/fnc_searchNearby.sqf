/* ----------------------------------------------------------------------------
Function: CBA_fnc_searchNearby

Description:
	A function for a group to search a nearby building.
Parameters:
	Group (Group or Object)
Example:
	(group player) spawn CBA_fnc_searchNearby
Returns:
	Nil
Author:
	Rommel

---------------------------------------------------------------------------- */

#include "script_component.hpp"

_group = _this call CBA_fnc_getGroup;
_group lockWP true;
private ["_leader","_behaviour"];
_leader = leader _group;
_behaviour = behaviour _leader;
_group setBehaviour "COMBAT";

private ["_array", "_building", "_indices"];
_array = _leader call CBA_fnc_getNearestBuilding;
_building = ARG_2(_array, 0);
_indices = ARG_2(_array, 1);
_group setFormDir ([_leader, _building] call BIS_fnc_dirTo);

if (([_group, _building] call CBA_fnc_getDistance) > 500) exitwith {_group lockWP false};

private ["_count","_units"];
_units = units _group;
_count = (count _units) - 1;

while {_indices > 0 and _count > 0} do {
	sleep 10;
	while {_indices > 0 and _count > 0} do {
		private "_unit";
		_unit = (_units select _count);
		if (unitReady _unit) then {
			_unit commandMove (_building buildingPos _indices);
			_unit spawn {
				sleep 5;
				waituntil {unitReady _this};
			};
			_indices = _indices - 1;
		};
		_count = _count - 1;
	};
	_units = units _group;
	_count = (count _units) - 1;
};
waituntil {sleep 3;	{unitReady _x} count _units == count (units _group) - 1};
{
	_x doFollow _leader;
} foreach _units;
_group setBehaviour _behaviour;
_group lockWP false;