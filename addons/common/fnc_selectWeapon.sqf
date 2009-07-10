/* ----------------------------------------------------------------------------
Function: CBA_fnc_selectWeapon

Description:
	Selects weapon, if the player has the weapon, including correctly selecting a muzzle, if any.
	
Parameters:
	_unit - Unit object to perform function on [Object]
	_weap - Weapon to select [String]

Returns:
	Success or Failed [Boolean]

Examples:
	(begin example)

	(end)

Author:
	Sickboy
---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(selectWeapon);

private ["_cfg", "_muz", "_ar"];
PARAMS_2(_unit,_weap);
_cfg = (configFile >> "CfgWeapons" >> _weap >> "muzzles");
if (isArray _cfg) then
{
	_ar = getArray _cfg;
	_muz = _ar select 0;
	if (_muz == "this") then { _muz = _weap };
} else {
	_muz = _weap;
};

sleep 1;
if (player hasWeapon _weap) then { _unit selectWeapon _muz; true } else { false };
