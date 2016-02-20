/* ----------------------------------------------------------------------------
Function: CBA_fnc_addLocalEventHandler

Description:
    Registers an event handler for a specific CBA event which only runs where the first parameter (object) is local.

Parameters:
    _eventType - Type of event to handle [String].
    _handler - Function to call when event is raised [Code].

Returns:
    Index of the event handler (can be used with <CBA_fnc_removeEventHandler>).

Author:
    Xeno
---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(addLocalEventHandler);

// -----------------------------------------------------------------------------

params ["_eventType","_handler"];

private ["_handlers", "_handlerIndex"];

_handlers = CBA_eventHandlersLocal getVariable _eventType;

if (isNil "_handlers") then {
    // No handlers for this event already exist, so make a new event type.
    CBA_eventHandlersLocal setVariable [_eventType, [_handler]];
    _handlerIndex = 0;
} else {
    // Handlers already recorded, so add another one.
    _handlerIndex = count _handlers;
    _handlers pushBack _handler;
};

TRACE_2("Added",_eventType,_handlerIndex);

_handlerIndex; // Return.
