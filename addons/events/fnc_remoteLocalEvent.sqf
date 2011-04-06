/* ----------------------------------------------------------------------------
Function: CBA_fnc_remoteLocalEvent

Description:
	Raises a CBA event only on the machine where parameter one is local.

Parameters:
	_eventType - Type of event to publish [String].
	_params - Parameters to pass to the event handlers. First param must be the object to check

Returns:
	nil

Author:
	Xeno
---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(remoteLocalEvent);

// ----------------------------------------------------------------------------
PARAMS_1(_eventType);
DEFAULT_PARAM(1,_params,nil);

private "_locobj";
_locobj = if (typeName _params == typeName []) then {_params select 0} else {_params};

// doing a local check first
if (!local _locobj) exitWith {
	TRACE_1("Not local",_locobj);
	nil
};

TRACE_1("",_locobj);

private "_handlers";
_handlers = CBA_eventHandlersLocal getVariable _eventType;

if (!isNil "_handlers") then {
	{
		if (!isNil "_x") then {
			if (isNil "_params") then {
				call _x;
			} else {
				_params call _x;
			};
		};
	} forEach _handlers;
};

nil; // Return.
