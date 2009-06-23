/* ----------------------------------------------------------------------------
Function: CBA_fnc_determineMuzzles

Description:
	Gets the list of possible muzzles for a weapon.
	
Parameters:

Returns:

Examples:
	(begin example)

	(end)

Author:

---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(determineMuzzles);

#define __cfg configFile >> "CfgWeapons" >> _this

private ["_r"];
_r = [__cfg];
if (isArray(__cfg >> "muzzles")) then
{
	_ar = getArray(__cfg >> "muzzles");
	if (count _ar == 0) exitWith {};
	if ((_ar select 0) == "this") exitWith {};
	_r = _ar;
};
_r