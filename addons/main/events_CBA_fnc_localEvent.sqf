/* ----------------------------------------------------------------------------
@description Raises a CBA event only on the local machine.

Parameters:
  0: _eventType - Type of event to publish [String].
  1: _params - Parameters to pass to the event handlers [Array].

Returns:
  nil

---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(localEvent);

// ----------------------------------------------------------------------------

PARAMS_2(_eventType,_params);
	
private ["_handlerFunctionsName", "_handlerFunctions"];

// Run locally.
_handlerFunctionsName = _eventType + "_handlers";

if (not (isNil _handlerFunctionsName)) then
{
	_handlerFunctions = call compile _handlerFunctionsName;
	
	{
		if (not (isNil "_x")) then
		{
			_params call _x;
		};
	} forEach _handlerFunctions;
};

nil; // Return.