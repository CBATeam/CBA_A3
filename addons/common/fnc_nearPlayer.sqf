/* ----------------------------------------------------------------------------
Function: CBA_fnc_nearPlayer

Description:
	Check whether these are any players within a certain distance of a unit.
	
Parameters:

Returns:

Examples:
	(begin example)

	(end)

Author:

---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(nearPlayer);

PARAMS_2(_unit,_distance);

private "_ok";
_ok = false;

{
	if ((_unit distance _x) < _distance) exitWith { _ok = true };
} forEach ([] call CBA_fnc_players);

_ok