/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeReceiverOnlyEvent

Description:
	Removes an event handler previously registered with CBA_fnc_addReceiverOnlyEventhandler.

Parameters:
	_eventType - Type of event to remove [String].

Returns:
	nil

Author:
	Xeno
---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(removeReceiverOnlyEvent);

if (!isNil {GVAR(event_holderToR) getVariable _this}) then {GVAR(event_holderToR) setVariable [_this, nil]};
