/*
Function: CBA_fnc_addPlayerAction

Description:
	Adds persistent action to player (which will also be available in vehicles
	and after respawn or teamswitch).

	Remove action with <CBA_fnc_removePlayerAction>. *Do not* use standard
	removeAction command with these player-action indices!

Parameters:
	_actionArray - Array that defines the action, as used in addAction command [Array]

Returns:
	Index of action if added. -1 if used on a dedicated server [Number]

Example:
	(begin example)
		_actionIndex = [["Teleport", "teleport.sqf"]] call CBA_fnc_addPlayerAction;
	(end)

Author:
	Sickboy

*/
#include "script_component.hpp"

PARAMS_1(_actionArray);

private "_return";

_return = if (isDedicated) then
{
	WARNING("Function ran on a dedicated server. Function only usable on a client. Action: " + str _actionArray);
	-1; // Invalid action number.
} else {
	_index = GVAR(nextActionIndex);
	[GVAR(actionList), _index, _actionArray] call CBA_fnc_hashSet;
	GVAR(actionListUpdated) = true;
	INC(GVAR(nextActionIndex));
	_index;
};

_return;

