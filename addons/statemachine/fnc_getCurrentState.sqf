#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_statemachine_fnc_getCurrentState

Description:
    Manually triggers a transition.

Parameters:
    _listItem       - item to get the state of <any namespace type>
    _stateMachine   - state machine <LOCATION>

Returns:
    _currentState   - state of the given item <STRING>

Examples:
    (begin example)
        _currentState = [player, _stateMachine] call CBA_statemachine_fnc_getCurrentState;
    (end)

Author:
    BaerMitUmlaut
---------------------------------------------------------------------------- */
SCRIPT(getCurrentState);
params [
    ["_listItem", objNull, [missionNamespace, objNull, grpNull, teamMemberNull, taskNull, locationNull]],
    ["_stateMachine", locationNull, [locationNull]]
];

private _id = _stateMachine getVariable QGVAR(ID);
[_listItem getVariable (QGVAR(state) + str _id)] param [0, _stateMachine getVariable QGVAR(initialState)];
