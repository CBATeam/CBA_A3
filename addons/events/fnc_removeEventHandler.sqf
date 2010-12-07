/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeEventHandler

Description:
	Removes an event handler previously registered with CBA_fnc_addEventHandler.

Parameters:
	_eventType - Type of event to remove [String].
	_handlerIndex - Index of the event handler to remove [Number].

Returns:
	nil

TODO:
	Use Hash to store handlers as a sparse array, to save on lots of empty
	elements in the array if lots of removes are made.

Author:
	Spooner
---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(removeEventHandler);

// -----------------------------------------------------------------------------

PARAMS_2(_eventType,_handlerIndex);

private "_handlers";

_handlers = CBA_eventHandlers getVariable _eventType;

if (isNil "_handlers") then
{
	WARNING("Event type not registered: " + (str _eventType));
} else {
	if ((count _handlers) > _handlerIndex) then
	{
		if (isNil { _handlers select _handlerIndex } ) then
		{
			WARNING("Handler for event " + (str _eventType) + " index " + (str _handlerIndex) + " already removed.");
		} else {
			_handlers set [_handlerIndex, nil];
			TRACE_2("Removed",_eventType,_handlerIndex);
		};
	} else {
		WARNING("Handler for event " + (str _eventType) + " index " + (str _handlerIndex) + " never set.");
	};
};

nil; // Return.
