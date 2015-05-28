/* ----------------------------------------------------------------------------
Function: CBA_fnc_addClientToServerEventhandler

Description:
    Registers an event handler for a client to server event which only runs on the server (thus is only needed on the server)

Parameters:
    _eventType - Type of event to handle [String].
    _handler - Function to call when event is raised [Code].

Returns:
    Nothing

Author:
    Xeno
---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(addClientToServerEventhandler);

if (!isServer) exitWith {};

private ["_ea"];
_ea = GVAR(event_holderCTS) getVariable (_this select 0);
if (isNil "_ea") then {_ea = []};
_ea pushBack (_this select 1);
GVAR(event_holderCTS) setVariable [_this select 0, _ea];