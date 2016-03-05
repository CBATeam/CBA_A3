/* ----------------------------------------------------------------------------
Function: CBA_fnc_remoteEvent

Description:
    Raises a CBA event on all machines, except the local one.

Parameters:
    _eventName - Type of event to publish. <STRING>
    _params    - Parameters to pass to the event handlers. <ANY>

Returns:
    None

Examples:
    (begin example)
        ["test", ["remote"]] call CBA_fnc_remoteEvent;
    (end)

Author:
    Spooner, commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(remoteEvent);

params [["_eventName", "", [""]], ["_params", []]];

SEND_EVENT_TO_OTHERS(_params,_eventName);

nil
