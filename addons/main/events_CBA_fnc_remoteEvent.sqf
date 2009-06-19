/* ----------------------------------------------------------------------------
Function: CBA_fnc_remoteEvent

Description:
	Raises a CBA event on all machines EXCEPT the local one.

Parameters:
	_eventType - Type of event to publish [String].
	_params - Parameters to pass to the event handlers [Array].

Returns:
	nil

---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(remoteEvent);

// ----------------------------------------------------------------------------

PARAMS_2(_eventType,_params);

// Run remotely.
call compile format ["%1 = _params", _eventType];
publicVariable _eventType;

nil; // Return.