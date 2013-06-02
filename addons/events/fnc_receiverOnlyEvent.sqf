/* ----------------------------------------------------------------------------
Function: CBA_fnc_receiverOnlyEvent

Description:
	Raises an CBA event only on the receiver and is only broadcasted there
	Can be called on any client or on the server.
	If called on a client the params are broadcasted to the server first, server then checks the owner and sends the params only to that specific client

Parameters:
	_eventType - Type of event to publish [String].
	_params - Parameters to pass to the event handlers [Array]. First param must be an object to check for the owner!!!


Returns:
	nil

Author:
	Xeno
---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(receiverOnlyEvent);

private ["_tt", "_obj", "_isLocal"];
_tt = _this select 1;
_obj = if (typeName _tt == "ARRAY") then {_tt select 0} else {_tt};
if (isNil "_obj" || {isNull _obj}) exitWith {};
_islocal = if (typeName _obj != "GROUP") then {
	local _obj
} else {
	local (leader _obj)
};
if (!_isLocal) then {
	CBA_ntor = _this;
	publicVariableServer "CBA_ntor";
} else {
	_this call FUNC(NetRunEventTOR);
};