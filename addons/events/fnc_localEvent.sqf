/* ----------------------------------------------------------------------------
Function: CBA_fnc_localEvent

Description:
    Raises a CBA event only on the local machine.

Parameters:
    _eventType - Type of event to publish [String].
    _params - Parameters to pass to the event handlers [Array, defaults to nil].

Returns:
    nil

Author:
    Spooner
---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(localEvent);

// ----------------------------------------------------------------------------

params ["_eventType", ["_params",nil]];

private "_handlers";

// Run locally.
_handlers = CBA_eventHandlers getVariable _eventType;

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
