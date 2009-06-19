/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeEventHandler

Description:
	Removes an event handler previously registered with CBA_fnc_addEventHandler.

Parameters:
	_eventType - Type of event to remove [String].
	_handlerIndex - Index of the event handler to remove [Number].

Returns:
	nil

---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(removeEventHandler);

// -----------------------------------------------------------------------------

PARAMS_2(_eventType,_handlerIndex);

private ["_handlerFunctionsName", "_handlerFunctions"];

_handlerFunctionsName = _eventType + "_handlers";

if (isNil _handlerFunctionsName) then
{
	// ERROR!
}
else
{
	_handlerFunctions = call compile _handlerFunctionsName;
	if ((count _handlerFunctions) > _handlerIndex) then
	{
		_handlerFunctions set [_handlerIndex, nil];
	}
	else
	{
		// ERROR!
	};
};

TRACE_2("",_eventType,_handlerIndex);

nil; // Return.