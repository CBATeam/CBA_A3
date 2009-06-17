/* ----------------------------------------------------------------------------
@description Registers an event handler for a specific CBA event.

Parameters:
  0: _eventType - Type of event to handle [String].
  1: _handlerCode - Code to call when event is raised [Code].

Returns:
  Index of the event handler (can be used with CBA_fnc_removeEventHandler).

---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(addEventHandler);

// -----------------------------------------------------------------------------

PARAMS_2(_eventType,_handlerCode);

private ["_handlerFunctionsName", "_handlerFunctions", "_handlerIndex"];

// Run locally.
_handlerFunctionsName = _eventType + "_handlers";

if (isNil _handlerFunctionsName) then
{
	// No handlers for this event already exist, so make a new event type.
	call compile format ["%1 = [_handlerCode]", _handlerFunctionsName];
	_handlerIndex = 0;
	
	// Make sure that there is an event handler to catch global events.
	_eventType addPublicVariableEventHandler CBA_fnc_localEvent;
}
else
{
	// Handlers already recorded, so add another one.
	_handlerFunctions = call compile _handlerFunctionsName;
	_handlerIndex = count _handlerFunctions;
	PUSH(_handlerFunctions,_handlerCode);
};

TRACE_2("",_eventType,_handlerIndex);

_handlerIndex; // Return.