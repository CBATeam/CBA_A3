/* ----------------------------------------------------------------------------
Function: CBA_fnc_players

Description:
	Get a list of current players.

Parameters:

Returns:

Examples:
	(begin example)

	(end)

Author:

---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(players);

private "_ar";

_ar = [];
{ if (isPlayer _x) then { PUSH(_ar,_x) } } forEach playableUnits;
_ar
