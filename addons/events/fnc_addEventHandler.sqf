/* ----------------------------------------------------------------------------
Function: CBA_fnc_addEventHandler

Description:
    Registers an event handler for a specific CBA event.

Parameters:
    _eventType - Type of event to handle [String].
    _handler - Function to call when event is raised [Code].

Returns:
    Index of the event handler (can be used with <CBA_fnc_removeEventHandler>).

Author:
    Spooner
---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(addEventHandler);

// -----------------------------------------------------------------------------

PARAMS_2(_eventType,_handler);

private ["_handlers", "_handlerIndex"];

_handlers = CBA_eventHandlers getVariable _eventType;

if (isNil "_handlers") then {
    // No handlers for this event already exist, so make a new event type.
    CBA_eventHandlers setVariable [_eventType, [_handler]];
    _handlerIndex = 0;
} else {
    // Handlers already recorded, so add another one.
    _handlerIndex = count _handlers;
    PUSH(_handlers,_handler);
};

TRACE_2("Added",_eventType,_handlerIndex);

_handlerIndex; // Return.
