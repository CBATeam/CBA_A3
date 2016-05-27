/* ----------------------------------------------------------------------------
Function: CBA_fnc_ownerEvent

Description:
    Raises a CBA event on the target client ID's machine.

Parameters:
    _eventName   - Type of event to publish. <STRING>
    _params      - Parameters to pass to the event handlers. <ANY>
    _targetOwner - Where to execute events. <NUMBER>

Returns:
    None

Examples:
    (begin example)
        ["test", ["target"], 3] call CBA_fnc_ownerEvent;
    (end)

Author:
    PabstMirror
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(ownerEvent);

params [["_eventName", "", [""]], ["_params", []], ["_targetOwner", -1, [0]]];
TRACE_3("params",_eventName,_params,_targetOwner);

if (_targetOwner == 2) then { //Going to server:
    if (isServer) then {
        //We are the server: Do local event (no network traffic)
        [_eventName, _params] call CBA_fnc_localEvent;
    } else {
        //Remote Server, send event (using publicVariableServer)
        //Note: publicVariableClient does not seem to work on dedicated
        SEND_EVENT_TO_SERVER(_params,_eventName);
    };
} else {
    if (CBA_clientID == _targetOwner) then {
        //We are the target client: Do local event (no network traffic)
        //Note: publicVariableClient to yourself DOES trigger addPublicVariableEventHandler, but it also causes network traffic
        [_eventName, _params] call CBA_fnc_localEvent;
    } else {
        //Remote Client, send event (using publicVariableClient)
        SEND_EVENT_TO_CLIENT(_params,_eventName,_targetOwner);
    };
};

nil
