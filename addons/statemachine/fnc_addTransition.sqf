#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_statemachine_fnc_addTransition

Description:
    Creates a transition between two states.

Parameters:
    _stateMachine   - a state machine <LOCATION>
    _originalState  - state the transition origins from <STRING>
    _targetState    - state the transition goes to <STRING>
    _condition      - condition under which the transition will happen <CODE>
    _onTransition   - code that gets executed once transition happens <CODE>
                      (Default: {})
    _name           - name for this specific transition <STRING>
                      (Default: "NONAME")
    _condFrequency  - time needed between transition condition checks <NUMBER>

Returns:
    _wasCreated     - check if the transition was created <BOOL>

Examples:
    (begin example)
        [_stateMachine, "initial", "end", {true}, {
            systemChat format [
                "%1 transitioned from %2 to %3 via %4.",
                _this, _thisOrigin, _thisTarget, _thisTransition
            ];
        }, "dummyTransition"] call CBA_statemachine_fnc_addTransition;
    (end)

Author:
    BaerMitUmlaut
---------------------------------------------------------------------------- */
SCRIPT(addTransition);
params [
    ["_stateMachine", locationNull, [locationNull]],
    ["_originalState", "", [""]],
    ["_targetState", "", [""]],
    ["_condition", {}, [{}]],
    ["_onTransition", {}, [{}]],
    ["_name", "NONAME", [""]],
    ["_condFrequency", 0, [0]]
];

private _states = _stateMachine getVariable QGVAR(states);

if (isNull _stateMachine
    || {!(_originalState in _states)}
    || {!(_targetState in _states)}
    || {_condition isEqualTo {}}
) exitWith {false};

private _transitions = _stateMachine getVariable TRANSITIONS(_originalState);
_transitions pushBack [_name, _condition, _targetState, _onTransition, _condFrequency];
_stateMachine setVariable [TRANSITIONS(_originalState), _transitions];

true
