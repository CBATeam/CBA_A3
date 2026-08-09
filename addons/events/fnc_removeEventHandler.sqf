#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeEventHandler

Description:
    Removes an event handler previously registered with CBA_fnc_addEventHandler.

Parameters:
    _eventName - Type of event to remove. <STRING>
    _eventId   - Unique ID of the event handler to remove. <NUMBER>

Returns:
    None

Examples:
    (begin example)
        ["test", _id] call CBA_fnc_removeEventHandler;
    (end)

Author:
    Spooner, commy2
---------------------------------------------------------------------------- */
SCRIPT(removeEventHandler);

params [["_eventName", "", [""]], ["_eventId", -1, [0]]];

{
    if (_eventId < 0) exitWith {};

    private _events = GVAR(eventNamespace) getVariable _eventName;
    private _eventIds = GVAR(eventHashes) getVariable _eventName;

    if (isNil "_events") exitWith {};

    private _internalId = _eventIds getOrDefault [_eventId, -1];

    if (_internalId != -1) then {
        _events deleteAt _internalId;
        _eventIds deleteAt _eventId;

        // decrement all higher internal ids, to adjust to new array position, _x == _eventId, _y == _internalId
        {
            if ((_y > _internalId) && (_x isNotEqualTo LAST_ID_KEY)) then {
                _eventIds set [_x, _y - 1];
            };
        } forEach _eventIds;
    };
} call CBA_fnc_directCall;

nil
