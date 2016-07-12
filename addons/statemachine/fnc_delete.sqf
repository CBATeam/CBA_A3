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
#include "script_component.hpp"
SCRIPT(delete);
params [["_stateMachine", locationNull, [locationNull]]];

if (isNil QGVAR(stateMachines)) exitWith {};

private _index = GVAR(stateMachines) find _stateMachine;
if (_index != -1) then {
    GVAR(stateMachines) deleteAt _index;
    [_stateMachine] call CBA_fnc_deleteNamespace;
};
