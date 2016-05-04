/* ----------------------------------------------------------------------------
Function: CBA_statemachine_fnc_addState

Description:
    Adds a state to a state machine.

Parameters:
    _stateMachine   - a state machine <LOCATION>
    _onState        - code that is executed when state is active (frequency
                      depends on amount of objects active in state machine)
                      <CODE>
    _name           - unique state name <STRING>
                      (Default: "stateX" with X being a unique number)

Returns:
    _name           - unique state name or empty string on error <STRING>

Examples:
    (begin example)
        _name = [_stateMachine, {}] call CBA_statemachine_fnc_addState;
    (end)

Author:
    BaerMitUmlaut
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(addState);
params [
    ["_stateMachine", locationNull, [locationNull]],
    ["_onState", {}, [{}]],
    ["_name", "", [""]]
];

private _states = _stateMachine getVariable QGVAR(states);

if (isNull _stateMachine || {_name in _states}) exitWith {""};

// Autogenerate unique name
if (_name == "") then {
    private _nextUniqueID = _stateMachine getVariable QGVAR(nextUniqueStateID);
    _name = "state" + str _nextUniqueID;
    _stateMachine setVariable [QGVAR(nextUniqueStateID), _nextUniqueID + 1];
};

_states pushBack _name;
_stateMachine setVariable [QGVAR(states), _states];
_stateMachine setVariable [ONSTATE(_name), _onState];
_stateMachine setVariable [TRANSITIONS(_name), []];

diag_log "derp";

// First state added is always the intial state
if (isNil {_stateMachine getVariable QGVAR(initialState)}) then {
    _stateMachine setVariable [QGVAR(initialState), _name];
    diag_log "initial state set";
};

_name
