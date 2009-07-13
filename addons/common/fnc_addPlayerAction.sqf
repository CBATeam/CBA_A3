/*
Function: CBA_fnc_addPlayerAction

Description:
	Adds persistent action to player (which will also be available in vehicles).
*/
#include "script_component.hpp"

PARAMS_1(_action);
TRACE_1(_this);

if (isDedicated) then
{
	WARNING("Function ran on a dedicated server. Function only usable on a client");
	false;
} else {
	if (_action in GVAR(actionlist)) then
	{
		WARNING("Action already persistent " + str(_action));
	} else {
		PUSH(GVAR(actionlist),_action);
	};
	true;
};
