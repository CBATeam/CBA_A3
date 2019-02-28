#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_statemachine_fnc_delete

Description:
    Deletes a state machine.

Parameters:
    _stateMachine   - a state machine <LOCATION>

Returns:
    Nothing

Examples:
    (begin example)
        [_stateMachine] call CBA_statemachine_fnc_delete;
    (end)

Author:
    BaerMitUmlaut
---------------------------------------------------------------------------- */
SCRIPT(delete);
params [["_stateMachine", locationNull, [locationNull]]];

if (isNil QGVAR(stateMachines)) exitWith {};

private _index = GVAR(stateMachines) find _stateMachine;
if (_index != -1) then {

    // all items exit their states before the machine gets deleted

    private _skipNull = _stateMachine getVariable QGVAR(skipNull);
    private _list = _stateMachine getVariable [QGVAR(list), []];

    if (_skipNull) then {
        _list = _list select {!isNull _x};
    };

    {
        _thisState = [_x, _stateMachine] call CBA_statemachine_fnc_getCurrentState;
        _x call (_stateMachine getVariable ONSTATELEAVING(_currentState));
        false
    } count _list;

    GVAR(stateMachines) deleteAt _index;
    [_stateMachine] call CBA_fnc_deleteNamespace;
};
