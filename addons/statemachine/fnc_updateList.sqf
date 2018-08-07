#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_statemachine_fnc_updateList

Description:
    Manually updates the list of a state machine.

Parameters:
    _stateMachine   - a state machine <LOCATION>
    _list           - list of anything over which the state machine will run
                      (type needs to support setVariable) <ARRAY>

Returns:
    Nothing

Examples:
    (begin example)
        [_stateMachine, _list] call CBA_statemachine_fnc_updateList;
    (end)

Author:
    BaerMitUmlaut
---------------------------------------------------------------------------- */
SCRIPT(updateList);
params [
    ["_stateMachine", locationNull, [locationNull]],
    ["_list", [], [[]]]
];

// Filter list in case null elements were passed
private _skipNull = _stateMachine getVariable QGVAR(skipNull);
if (_skipNull) then {
    _list = _list select {!isNull _x};
};

_stateMachine setVariable [QGVAR(list), _list];
