/* ----------------------------------------------------------------------------
Function: CBA_fnc_isTurnedOut

Description:
	Checks whether a unit is turned out in a vehicle or not.

Parameters:
	_unit - Unit to check [Object]

Returns:
	"true" for turned out or "false" for not turned out [Boolean]

Examples:
	(begin example)
		if ( [player] call CBA_fnc_isTurnedOut ) then
		{
			player sideChat "I am turned out!";
		};
	(end)

Author:
	(c) rocko 2008, 2009
---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(isTurnedOut);

private["_unit", "_anim", "_count", "_out", "_ret"];
PARAMS_1(_unit);
_anim = toArray(toLower(animationState _unit));
_count = (count _anim)-1;
_out = toString([_anim select (_count-2),_anim select (_count-1),_anim select _count]);
if(_out == "ep1") then {
	_out = toString([_anim select (_count-6),_anim select (_count-5),_anim select (_count-4)]);
};
if (_out == "out") then { _ret = true; } else { _ret = false; };
_ret

