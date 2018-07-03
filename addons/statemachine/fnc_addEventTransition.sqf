#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_statemachine_fnc_addEventTransition

Description:
    Creates a transition between two states.

Parameters:
    _stateMachine   - a state machine <LOCATION>
    _originalState  - state the transition origins from <STRING>
    _targetState    - state the transition goes to <STRING>
    _events         - list of events that can trigger the transition <ARRAY>
    _condition      - additional condition required for the transition to
                      trigger <CODE>
    _onTransition   - code that gets executed once transition happens <CODE>
                      (Default: {})
    _name           - name for this specific transition <STRING>
                      (Default: "NONAME")

Returns:
    _wasCreated     - check if the transition was created <BOOL>

Examples:
    (begin example)
        [_stateMachine, "initial", "end", ["end_statemachine"], {true}, {
            systemChat format [
                "%1 transitioned from %2 to %3 via %4.",
                _this, _thisOrigin, _thisTarget, _thisTransition
            ];
        }, "dummyTransition"] call CBA_statemachine_fnc_addEventTransition;
    (end)

Author:
    BaerMitUmlaut
---------------------------------------------------------------------------- */
SCRIPT(addEventTransition);
params [
    ["_stateMachine", locationNull, [locationNull]],
    ["_originalState", "", [""]],
    ["_targetState", "", [""]],
    ["_events", [], [[]]],
    ["_condition", {}, [{}, ""]],
    ["_onTransition", {}, [{}]],
    ["_name", "NONAME", [""]]
];

private _states = _stateMachine getVariable QGVAR(states);

if (isNull _stateMachine
    || {!(_originalState in _states)}
    || {!(_targetState in _states)}
    || {!(_events isEqualTypeAll "")}
) exitWith {false};

if (_condition isEqualTo {}) then {
    _condition = {true};
};

{
    [_x, {
        params ["_listItem"];
        // The condition needs to be able to access these variables
        _thisArgs params [
            "_condition",
            "_stateMachine",
            "_thisOrigin",
            "_thisTarget",
            "",
            "_thisTransition"
        ];
        private _thisState = _thisOrigin;

        if (([_listItem, _stateMachine] call FUNC(getCurrentState)) != _thisState) exitWith {};

        if (_listItem call _condition) then {
            // Replace condition with listItem for params
            private _args =+ _thisArgs;
            _args set [0, _listItem];
            _args call FUNC(manualTransition);
        };
    }, [_condition, _stateMachine, _originalState, _targetState, _onTransition, _name]] call CBA_fnc_addEventHandlerArgs;
} forEach _events;

private _eventTransitions = _stateMachine getVariable EVENTTRANSITIONS(_originalState);
_eventTransitions pushBack [_name, _events, _condition, _targetState, _onTransition];
_stateMachine setVariable [EVENTTRANSITIONS(_originalState), _eventTransitions];

true
