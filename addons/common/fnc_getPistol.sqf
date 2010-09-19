/* ----------------------------------------------------------------------------
Function: CBA_fnc_getPistol

Description:
	Returns name of pistol in unit's inventory, if any.

Parameters:
	_unit - Unit to check for a pistol in [Object]

Returns:
	Class name of pistol, if carried, otherwise "" [String]

Examples:
	(begin example)
		_pistol = [player] call CBA_fnc_getPistol;
		// => "", assuming that the player was not carrying any pistol.
		// => "Makarov", assuming that the player was carrying a Makarov pistol.
	(end)

Author:
	Sickboy
---------------------------------------------------------------------------- */

#include "script_component.hpp"

#define PISTOL_TYPE 2

SCRIPT(getPistol);

private ["_pistol", "_unit"];
_pistol = "";

// Backwards compatibility (deprecated). Accept array or single value.
if (IS_ARRAY(_this)) then
{
	_unit = _this select 0;
}
else
{
	_unit = _this;
	WARNING("Expected [_unit], not _unit, passed to function. Unit was: " + str _unit);
};

if (_unit isKindOf "man") then
{
	{
		if ((getNumber (configFile >> "CfgWeapons" >> _x >> "Type")) == PISTOL_TYPE) exitWith
		{
			_pistol = _x;
		};
	} forEach (weapons _unit);
};

_pistol;
