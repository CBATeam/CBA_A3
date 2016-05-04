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
#include "script_component.hpp"
SCRIPT(updateList);
params [
    ["_stateMachine", locationNull, [locationNull]],
    ["_list", [], [[]]]
];

_stateMachine setVariable [QGVAR(list), _list];
