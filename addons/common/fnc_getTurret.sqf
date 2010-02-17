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

#define __cfg (configFile >> "CfgVehicles" >> (typeof _v))
private ["_path"];
PARAMS_2(_v,_tp);
_path = __cfg;

if (count _tp > 0) then
{
	{ _path = ((_path >> "turrets") select _x) } forEach _tp;
};

TRACE_1("Result",_path);
_path;
