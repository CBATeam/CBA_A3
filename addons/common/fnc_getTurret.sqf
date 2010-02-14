/* ----------------------------------------------------------------------------
Function: CBA_fnc_getTurret

Description:
	A function used to find out which config turret is turretpath.
Parameters:
	Vehicle
	Turretpath
Example:
	_config = [vehicle player, [0]] call CBA_fnc_getTurret
Returns:
	Turret Config entry
Author:
	Sickboy

---------------------------------------------------------------------------- */

#define DEBUG_MODE_FULL
#include "script_component.hpp"

#define __cfg (configFile >> "CfgVehicles" >> (typeof _v) >> "turrets")

PARAMS_2(_v,_tp);

_path = (__cfg select (_tp select 0));
if (count _tp > 1) then
{
	{
		_path = _path select _x;
	} forEach _tp;
};

_path;
