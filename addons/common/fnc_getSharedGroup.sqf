/* ----------------------------------------------------------------------------
Function: CBA_fnc_getSharedGroup

Description:
	Returns existing group on side, or newly created group when not existent.
	
Parameters:
	_side - Side to get group for [Side]

Returns:
	Group [Group]
	
Examples:
	(begin example)
	(end)

Author:
	Sickboy
---------------------------------------------------------------------------- */
#include "script_component.hpp"

#define SIDES [east, west, resistance, civilian, sideLogic]

PARAMS_1(_side);

private ["_group", "_idx", "_center"];
_group = grpNull;
_idx = SIDES find _side;
if (_idx > - 1) then
{
	if (isNull (GVAR(groups) select _idx)) then
	{
		_center = [_side] call CBA_fnc_createCenter;
		_group = createGroup _center;
		GVAR(groups) set [_idx, _group];
		// TODO: Evaluate if this doesn't mess things up when multiple clients are requesting groups
		publicVariable QUOTE(GVAR(groups));
	} else {
		_group = GVAR(groups) select _idx;
	};
} else {
	WARNING("Illegal side parameter!");
};

_group;
