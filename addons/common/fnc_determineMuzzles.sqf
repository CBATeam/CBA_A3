/* ----------------------------------------------------------------------------
Function: CBA_fnc_determineMuzzles

Description:
	Gets the list of possible muzzles for a weapon.

Parameters:
	_weap - name of the weapon to examine [String]

Returns:
	- array of muzzle names if the weapon has muzzles and the first
	  muzzle is not "this"
	- nil (nothing) otherwise

Examples:
	(begin example)
	_muzzles = "M4A1_RCO_GL" call CBA_fnc_determineMuzzles
	// _muzzles = ["M4_ACOG_Muzzle", "M203Muzzle"]
	(end)

Author:

---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(determineMuzzles);
PARAMS_1(_weap);
#define __cfg configFile >> "CfgWeapons" >> _weap

private ["_r"];
_r = [_weap];
if (isArray(__cfg >> "muzzles")) then
{
	_ar = getArray(__cfg >> "muzzles");
	if (count _ar == 0) exitWith {};
	if ((_ar select 0) == "this") exitWith {};
	_r = _ar;
};

_r;
