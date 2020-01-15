#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_turretEvent

Description:
    Raises a CBA event on the machine where the vehicle's turret is local.

Parameters:
    _eventName  - Type of event to publish. <STRING>
    _params     - Parameters to pass to the event handlers. <ANY>
    _vehicle    - Vehicle to which the turret belongs. <OBJECT>
    _turretPath - The turret to execute on. Will accept both [] and [-1] for driver's turret. <ARRAY>

Returns:
    None

Examples:
    (begin example)
        ["test", ["turret"], cursorObject, [-1]] call CBA_fnc_turretEvent;
    (end)

Author:
    NeilZar
---------------------------------------------------------------------------- */
SCRIPT(turretEvent);

params [["_eventName", "", [""]], ["_params", []], ["_vehicle", objNull, [objNull]], ["_turretPath", [-1], [[]]]];

if (_turretPath isEqualTo []) then {
    _turretPath = [-1];
};

if (_vehicle turretLocal _turretPath) exitWith {
    CALL_EVENT(_params,_eventName);
};

if (isServer) then {
    // retrieve the turret owner and send the event
    private "_turretOwner";
    if (_turretPath isEqualTo [-1]) then {
        _turretOwner = owner _vehicle;
    } else {
        _turretOwner = _vehicle turretOwner _turretPath;
    };

    SEND_EVENT_TO_CLIENT(_params,_eventName,_turretOwner);
} else {
    // only server knows turret owners. let server handle the event.
    SEND_TUEVENT_TO_SERVER(_params,_eventName,_vehicle,_turretPath);
};

nil
