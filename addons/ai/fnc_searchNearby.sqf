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

PARAMS_1(_group);
_group = _group call CBA_fnc_getGroup;
private ["_leader","_behaviour"];
_leader = leader _group;
_behaviour = behaviour _leader;

private ["_array", "_building", "_indices"];
_array = _leader call CBA_fnc_getNearestBuilding;
_building = ARG_1(_array, 0);
_indices = ARG_1(_array, 1);

if (_leader distance _building > 500) exitwith {};

_group setFormDir ([_leader, _building] call BIS_fnc_dirTo);
_group setBehaviour "COMBAT";
_group lockWP true;

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