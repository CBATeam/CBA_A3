/*
Function: CBA_fnc_removePlayerAction

Description:
	Removes player action.
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
		SUB(GVAR(actionlist),[_action]);
	} else {
		WARNING("Action was already not persistent " + str(_action));
	};
	true;
};
