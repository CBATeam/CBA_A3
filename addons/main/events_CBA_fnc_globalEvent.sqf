/* ----------------------------------------------------------------------------
@description Raises a CBA event on all machines, including the local one.

Parameters:
  0: _eventType - Type of event to publish [String].
  1: _params - Parameters to pass to the event handlers [Array].

Returns:
  nil

---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(globalEvent);

// ----------------------------------------------------------------------------

_this call CBA_fnc_remoteEvent;
_this call CBA_fnc_localEvent;

nil; // Return.