#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_addEventHandler

Description:
    Registers an event handler for a specific CBA event.

Parameters:
    _eventName - Type of event to handle. <STRING>
    _eventFunc - Function to call when event is raised. <CODE>

Returns:
    _eventId - Unique ID of the event handler (can be used with CBA_fnc_removeEventHandler).

Examples:
    (begin example)
        _id = ["test", {systemChat str _this}] call CBA_fnc_addEventHandler;
    (end)

Author:
    Spooner, commy2
---------------------------------------------------------------------------- */
SCRIPT(addEventHandler);

[{
    params [["_eventName", "", [""]], ["_eventFunc", nil, [{}]]];

    if (_eventName isEqualTo "" || isNil "_eventFunc") exitWith {-1};

    private _events = GVAR(eventNamespace) getVariable _eventName;
    private _eventIds = GVAR(eventHashes) getVariable _eventName;

    // generate event name on logic
    if (isNil "_events") then {
        _events = [];
        GVAR(eventNamespace) setVariable [_eventName, _events];

        _eventIds = createHashMap;
        GVAR(eventHashes) setVariable [_eventName, _eventIds];
    };

    private _internalId = _events pushBack _eventFunc;

    // get new id
    private _eventId = (_eventIds getOrDefault [LAST_ID_KEY, -1]) + 1;

    _eventIds set [LAST_ID_KEY, _eventId];
    _eventIds set [_eventId, _internalId];

    _eventId
}, _this] call CBA_fnc_directCall;
