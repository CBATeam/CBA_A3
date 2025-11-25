#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_localEvent

Description:
    Raises a CBA event on the local machine.

Parameters:
    _eventName - Type of event to publish. <STRING>
    _params    - Parameters to pass to the event handlers. <ANY> (optional)

Returns:
    _return - return value of the last added event function. <ANY>

Examples:
    (begin example)
        ["test", ["local"]] call CBA_fnc_localEvent;
    (end)

Author:
    Spooner, commy2
---------------------------------------------------------------------------- */
SCRIPT(localEvent);

params [["_eventName", "", [""]], ["_params", []]];

CALL_EVENT(_params,_eventName) // return
