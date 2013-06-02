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

private["_unit", "_anim", "_count", "_out"];
PARAMS_1(_unit);
_anim = toArray(toLower(animationState _unit));
_count = (count _anim) - 1;
_out = if (_anim select (_count-2) == 101 && {_anim select (_count-2) == 112} && {_anim select _count == 49}) then { // ep1
	[_anim select (_count-6),_anim select (_count-5),_anim select (_count-4)]
} else {
	[_anim select (_count-2),_anim select (_count-1),_anim select _count];
};

(_out select 0 == 111 && {_out select 1 == 117} && {_out select 2 == 116})  //out

