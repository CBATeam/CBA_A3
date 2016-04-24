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
    ["_type", "", [""]],
    ["_function", {}, [{}]],
    ["_arguments", []]
];

// retrieve unique variable name to store arguments, atomic to prevent race conditions
private _varID = {
    private _varID = _thing getVariable [format [QGVAR(lastID_%1), _type], -1];
    _varID = _varID + 1;
    _thing setVariable [format [QGVAR(lastID_%1), _type], _varID];
    _varID
} call CBA_fnc_directCall;

private _source = ["_this select 0", "missionNamespace"] select (_thing isEqualTo missionNamespace);

private _fnc = format ['
    ((%3) getVariable QGVAR(%1$%2)) params ["_thisType", "_thisId", "_thisFnc", "_thisArgs"];
    call _thisFnc
', _type, _varID, _source];

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
        addMissionEventHandler [_type, _fnc];
    };
    -1
};

if (_id >= 0) then {
    _thing setVariable [format [QGVAR(%1$%2), _type, _varID], [_type, _id, _function, _arguments]];
};

_id
