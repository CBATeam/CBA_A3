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
    ["_conditionFrequency", 0, [0]]
];

private _states = _stateMachine getVariable QGVAR(states);

if (isNull _stateMachine
    || {!(_originalState in _states)}
    || {!(_targetState in _states)}
    || {_condition isEqualTo {}}
) exitWith {false};

if (_conditionFrequency > 0) then {
    _condition = compile format [QUOTE(\
        private _return = false;\
        if ((_current getVariable [ARR_2((QQGVAR(lastCheckedState) + str _id), '')]) isEqualTo _thisState) then {\
            private _lastCheckedTime = _current getVariable [ARR_2((QQGVAR(lastCheckedTime) + str _id), CBA_MissionTime)];\
            if (CBA_MissionTime >= (_lastCheckedTime + %2)) then {\
                _current setVariable [ARR_2((QQGVAR(lastCheckedTime) + str _id), CBA_MissionTime)];\
                _return = true;\
            } else {\
                _return = false;\
            };\
        } else {\
            _current setVariable [ARR_2((QQGVAR(lastCheckedState) + str _id), _thisState)];\
            _current setVariable [ARR_2((QQGVAR(lastCheckedTime) + str _id), CBA_MissionTime)];\
            _return = false;\
        };\
        _return && %1\
    ), _condition, _conditionFrequency];
};

private _transitions = _stateMachine getVariable TRANSITIONS(_originalState);
_transitions pushBack [_name, _condition, _targetState, _onTransition];
_stateMachine setVariable [TRANSITIONS(_originalState), _transitions];

true
