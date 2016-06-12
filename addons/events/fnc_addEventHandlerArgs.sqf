/* ----------------------------------------------------------------------------
Function: CBA_fnc_addEventHandlerArgs

Description:
    Registers an event handler for a specific CBA event with arguments.

    A event added with this function will have the following variables defined:
    _this     - Arguments passed by function calling the events. <ANY>
    _thisArgs - Arguments added to event by this function. <ANY>
    _thisId   - Same as the return value of this function. <NUMBER>
    _thisType - Name of the event. (Same as _eventName passed to this function) <STRING>
    _thisFnc  - Piece of code added to the event by this function <CODE>

Parameters:
    _eventName - Type of event to handle. <STRING>
    _eventFunc - Function to call when event is raised. <CODE>
    _arguments - Arguments to pass to event handler. (optional) <Any>

Returns:
    _eventId - Unique ID of the event handler (can be used with CBA_fnc_removeEventHandler).

Examples:
    (begin example)
        ["test1", {
            systemChat str _thisArgs;
            [_thisType, _thisId] call CBA_fnc_removeEventHandler
        }, "hello world"] call CBA_fnc_addEventHandlerArgs;

        "test1" call CBA_fnc_localEvent;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(addEventHandlerArgs);

params [["_eventName", "", [""]], ["_eventFunc", nil, [{}]], ["_arguments", []]];

if (isNil QGVAR(eventsArgs)) then {
    GVAR(eventsArgs) = [];
};

private _eventData = [_arguments, _eventFunc, _eventName];
private _id = GVAR(eventsArgs) pushBack _eventData;

_eventFunc = compile format ['
    (GVAR(eventsArgs) select %1) params ["_thisArgs", "_thisFnc", "_thisType", "_thisId"];
    _this call _thisFnc;
', _id];

private _eventId = [_eventName, _eventFunc] call CBA_fnc_addEventHandler;

_eventData pushBack _eventId;
_eventId
