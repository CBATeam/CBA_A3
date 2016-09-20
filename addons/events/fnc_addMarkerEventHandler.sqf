/* ----------------------------------------------------------------------------
Function: CBA_fnc_addMarkerEventHandler

Description:
    Adds an event handler that executes code when a marker is created or deleted.

Parameters:
    _eventType - Type of event to add. Can be "created" or "deleted". <STRING>
    _function  - Function to call when marker is created or deleted. <CODE>

Returns:
    _eventId - Unique ID. Used with 'CBA_fnc_removeMarkerEventHandler'.

Examples:
    (begin example)
        _id = ["created", {systemChat str _this}] call CBA_fnc_addMarkerEventHandler;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(addMarkerEventHandler);

params [["_eventType", "", [""]], ["_function", {}, [{}]]];

if (isNil QGVAR(oldMarkers)) then {
    GVAR(oldMarkers) = allMapMarkers;

    [{
        private _newAllMapMarkers = allMapMarkers;
        if !(_newAllMapMarkers isEqualTo GVAR(oldMarkers)) then {
            params ["_events"];

            {
                [QGVAR(markerDeleted), _x] call CBA_fnc_localEvent;
            } forEach (GVAR(oldMarkers) - _newAllMapMarkers);

            {
                [QGVAR(markerCreated), _x] call CBA_fnc_localEvent;
            } forEach (_newAllMapMarkers - GVAR(oldMarkers));

            GVAR(oldMarkers) = _newAllMapMarkers;
        };
    }, 0] call CBA_fnc_addPerFrameHandler;
};

if (_function isEqualTo {}) exitWith {-1};

switch (toLower _eventType) do {
    case "created": {
        [QGVAR(markerCreated), _function] call CBA_fnc_addEventHandler // return
    };
    case "deleted": {
        [QGVAR(markerDeleted), _function] call CBA_fnc_addEventHandler // return
    };
    default {-1};
};
