/* ----------------------------------------------------------------------------
Function: CBA_fnc_getPistol

Description:
	Returns first found Pistol in unit's weaponList.
	
Parameters:

Returns:

Examples:
	(begin example)

	(end)

Author:

---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(getPistol);

private ["_r"];
_r = "";

if (_this isKindOf "man") then
{
	{ if ((getNumber (configFile >> "CfgWeapons" >> _x >> "Type")) == 2) exitWith { _r = _x } } forEach (weapons _this);
};

_r