/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeClientToServerEvent

Description:
	Removes an event handler previously registered with CBA_fnc_addClientToServerEventhandler.

Parameters:
	_eventType - Type of event to remove [String].

Returns:
	nil

Author:
	Xeno
---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(removeClientToServerEvent);

if (!isNil {GVAR(event_holderCTS) getVariable _this}) then {GVAR(event_holderCTS) setVariable [_this, nil]};
