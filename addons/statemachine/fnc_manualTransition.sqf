/* ----------------------------------------------------------------------------
Function: CBA_statemachine_fnc_manualTransition

Description:
    Manually triggers a transition.

Parameters:
    _listItem       - the item which should transition <any namespace type>
    _stateMachine   - a state machine <LOCATION>
    _thisOrigin     - state the transition origins from <STRING>
    _thisTarget     - state the transition goes to <STRING>
    _onTransition   - code that gets executed once transition happens <CODE>
                      (Default: {})
    _thisTransition - name for this specific transition <STRING>
                      (Default: "MANUAL")

Returns:
    Nothing

Examples:
    (begin example)
        [_stateMachine, "initial", "end", {
            systemChat format [
                "%1 transitioned from %2 to %3 manually.",
                _this, _thisOrigin, _thisTarget
            ];
        }, "dummyTransition"] call CBA_statemachine_fnc_manualTransition;
    (end)

Author:
    BaerMitUmlaut
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(manualTransition);
params [
    ["_listItem", objNull, [missionNamespace, objNull, grpNull, teamMemberNull, taskNull, locationNull]],
    ["_stateMachine", locationNull, [locationNull]],
    ["_thisOrigin", "", [""]],
    ["_thisTarget", "", [""]],
    ["_onTransition", {}, [{}]],
    ["_thisTransition", "MANUAL", [""]]
];
private _thisState = _thisOrigin;
private _id = _stateMachine getVariable QGVAR(ID);

_listItem call (_stateMachine getVariable ONSTATELEAVING(_thisOrigin));
_listItem call _onTransition;
_listItem setVariable [QGVAR(state) + str _id, _thisTarget];
_listItem call (_stateMachine getVariable ONSTATEENTERED(_thisTarget));
