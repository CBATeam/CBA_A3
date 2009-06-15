#define THIS_FILE CBA\main\remoteEvent
scriptName 'THIS_FILE';
// ----------------------------------------------------------------------------
// @description Raises a CBA event on all machines EXCEPT the local one.
//
// Parameters:
//   0: _eventType - Type of event to publish [String].
//   1: _params - Parameters to pass to the event handlers [Array].
//
// Returns:
//   nil
//
// ----------------------------------------------------------------------------

#include "script_component.hpp"

// ----------------------------------------------------------------------------

PARAMS_2(_eventType,_params);

// Run remotely.
call compile format ["%1 = _params", _eventType];
publicVariable _eventType;

nil; // Return.