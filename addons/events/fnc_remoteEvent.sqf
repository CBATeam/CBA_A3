/* ----------------------------------------------------------------------------
Function: CBA_fnc_remoteEvent

Description:
	Raises a CBA event on all machines EXCEPT the local one.

Parameters:
	_eventType - Type of event to publish [String].
	_params - Parameters to pass to the event handlers [Array].

Returns:
	nil

Author:
	Spooner
---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(remoteEvent);

// ----------------------------------------------------------------------------
// Run remotely.
CBA_e = _this;
publicVariable "CBA_e"; // Nasty short name to limit bandwidth.

nil; // Return.
