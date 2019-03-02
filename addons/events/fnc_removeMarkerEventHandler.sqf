#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeMarkerEventHandler

Description:
    Removes an event handler previously registered with 'CBA_fnc_addMarkerEventHandler'.

Parameters:
    _eventName - Type of event to remove. Can be "created" or "deleted". <STRING>
    _eventId   - Unique ID of the event handler to remove. <NUMBER>

Returns:
    None

Examples:
    (begin example)
        ["created", _id] call CBA_fnc_removeMarkerEventHandler;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
SCRIPT(removeMarkerEventHandler);

params [["_eventType", "", [""]], ["_eventId", -1, [0]]];

switch (toLower _eventType) do {
    case "created": {
        [QGVAR(markerCreated), _eventId] call CBA_fnc_removeEventHandler;
    };
    case "deleted": {
        [QGVAR(markerDeleted), _eventId] call CBA_fnc_removeEventHandler;
    };
};

nil
