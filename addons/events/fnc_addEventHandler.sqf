/* ----------------------------------------------------------------------------
Function: CBA_fnc_addEventHandler

Description:
    Registers an event handler for a specific CBA event.

Parameters:
    _eventName - Type of event to handle. <STRING>
    _eventFunc - Function to call when event is raised. <CODE>
    _arguments - Arguments to pass to event handler. (optional) <Any>

Returns:
    _eventId - Unique ID of the event handler (can be used with <CBA_fnc_removeEventHandler>).

Examples:
    (begin example)
        _id = ["test", {systemChat str _this}] call CBA_fnc_addEventHandler;
    (end)

Author:
    Spooner, commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(addEventHandler);

params [["_eventName", "", [""]], ["_eventFunc", nil, [{}]], ["_arguments", []]];

{
    if (_eventName isEqualTo "" || isNil "_eventFunc") exitWith {-1};

    private _events = GVAR(eventNamespace) getVariable _eventName;
    private _eventHash = GVAR(eventHashes) getVariable _eventName;

    // generate event name on logic
    if (isNil "_events") then {
        _events = [];
        GVAR(eventNamespace) setVariable [_eventName, _events];

        _eventHash = [[], -1] call CBA_fnc_hashCreate;
        GVAR(eventHashes) setVariable [_eventName, _eventHash];
    };

    private _eventData = [_eventFunc, _arguments];
    private _internalId = _events pushBack _eventData;

    // get last id
    private _eventId = [_eventHash, "#lastId"] call CBA_fnc_hashGet;

    // inc id
    _eventId = _eventId + 1;

    _eventData pushBack _eventId;
    [_eventHash, "#lastId", _eventId] call CBA_fnc_hashSet;
    [_eventHash, _eventId, _internalId] call CBA_fnc_hashSet;

    _eventId
} call CBA_fnc_directCall;
