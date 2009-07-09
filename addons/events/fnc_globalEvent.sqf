/* ----------------------------------------------------------------------------
Function: CBA_fnc_globalEvent

Description:
	Raises a CBA event on all machines, including the local one.

Parameters:
	_eventType - Type of event to publish [String].
	_params - Parameters to pass to the event handlers [Array].

Returns:
	nil

Author:
	Spooner
---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(globalEvent);

// ----------------------------------------------------------------------------

_this call CBA_fnc_remoteEvent;
_this call CBA_fnc_localEvent;

nil; // Return.
