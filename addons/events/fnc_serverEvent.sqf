#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_serverEvent

Description:
    Raises a CBA event on the server machine.

Parameters:
    _eventName - Type of event to publish. <STRING>
    _params    - Parameters to pass to the event handlers. <ANY>

Returns:
    None

Examples:
    (begin example)
        ["test", ["server"]] call CBA_fnc_serverEvent;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
SCRIPT(serverEvent);

params [["_eventName", "", [""]], ["_params", []]];

if (isServer) then {
    CALL_EVENT(_params,_eventName);
} else {
    SEND_EVENT_TO_SERVER(_params,_eventName);
};

nil
