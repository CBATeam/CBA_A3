/* ----------------------------------------------------------------------------
Function: CBA_fnc_addBISEventHandler

Description:
    Adds an event handler with arguments.
    Additional arguments are passed as _thisArgs. The ID is passed as _thisID.

Parameters:
    _object    - Thing to attach event handler to. <OBJECT, CONTROL, DISPLAY>
    _type      - Event handler type. <STRING>
    _function  - Function to add to event. <CODE>
    _arguments - Arguments to pass to event handler. <Any>

Returns:
    _id - The ID of the event handler. Same as _thisID <NUMBER>

Examples:
    (begin example)
        // one time fired event handler that removes itself
        _id = [player, "fired", {systemChat _thisArgs; player removeEventHandler ["fired", _thisID]}, "bananas"] call CBA_fnc_addBISEventHandler;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(addBISEventHandler);

params [
    ["_thing", objNull, [objNull, displayNull, controlNull, missionNamespace]],
    ["_type", "objNull", [""]],
    ["_function", {}, [{}]],
    ["_arguments", []]
];

// retrieve unique variable name to store arguments, atomic to prevent race conditions
private _varID = {
    private _varID = _thing getVariable [QGVAR(lastEventArgsID), -1];
    _varID = _varID + 1;
    _thing setVariable [QGVAR(lastEventArgsID), _varID];
    _varID
} call CBA_fnc_directCall;

private _fnc = format ['
    ((_this select 0) getVariable QGVAR($%1)) params ["_thisFnc", "_thisArgs", "_thisID"];
    call _thisFnc
', _varID];

private _id = call {
    if (_thing isEqualType objNull) exitWith {
        _thing addEventHandler [_type, _fnc];
    };

    if (_thing isEqualType displayNull) exitWith {
        _thing displayAddEventHandler [_type, _fnc];
    };

    if (_thing isEqualType controlNull) exitWith {
        _thing ctrlAddEventHandler [_type, _fnc];
    };

    if (_thing isEqualTo missionNamespace) exitWith {
        addMissionEventHandler [_type, format ['
            (missionNamespace getVariable QGVAR($%1)) params ["_thisFnc", "_thisArgs", "_thisID"];
            call _thisFnc
        ', _varID]];
    };
    -1
};

if (_id >= 0) then {
    _thing setVariable [format [QGVAR($%1), _varID], [_function, _arguments, _id]];
};

_id
