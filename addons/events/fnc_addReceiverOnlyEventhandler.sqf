/* ----------------------------------------------------------------------------
Function: CBA_fnc_addReceiverOnlyEventhandler

Description:
    Registers an event handler for an CBA event which is only broadcasted to the receiver (and no other clients)

Parameters:
    _eventType - Type of event to handle [String].
    _handler - Function to call when event is raised [Code].

Returns:
    Nothing

Author:
    Xeno
---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(addReceiverOnlyEventhandler);

private ["_ea"];
_ea = GVAR(event_holderToR) getVariable (_this select 0);
if (isNil "_ea") then {_ea = []};
_ea pushBack (_this select 1);
GVAR(event_holderToR) setVariable [_this select 0, _ea];