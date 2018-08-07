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
    private _eventHash = GVAR(eventHashes) getVariable _eventName;

    if (isNil "_events") exitWith {};

    private _internalId = [_eventHash, _eventId] call CBA_fnc_hashGet;

    if (_internalId != -1) then {
        _events deleteAt _internalId;
        [_eventHash, _eventId] call CBA_fnc_hashRem;

        // decrement all higher internal ids, to adjust to new array position, _key == _eventId, _value == _internalId
        [_eventHash, {
            if (_value > _internalId && {!(_key isEqualTo "#lastId")}) then {
                [_eventHash, _key, _value - 1] call CBA_fnc_hashSet;
            };
        }] call CBA_fnc_hashEachPair;
    };
} call CBA_fnc_directCall;

nil
