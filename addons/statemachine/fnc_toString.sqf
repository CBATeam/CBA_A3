/* ----------------------------------------------------------------------------
Function: CBA_statemachine_fnc_toString

Description:
    Creates a readable string representation of a state machine.

Parameters:
    _stateMachine   - a state machine <LOCATION>
    _outputList     - output list over which the state machine runs <BOOL>
                      (Default: false)
    _outputCode     - output code details such as the onState value <BOOL>
                      (Default: false)

Returns:
    _output         - string representation of state machine <STRING>

Examples:
    (begin example)
        _output = [_stateMachine, true] call CBA_statemachine_fnc_toString;
    (end)

Author:
    BaerMitUmlaut
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(toString);
params [
    ["_stateMachine", locationNull, [locationNull]],
    ["_outputList", false, [true]],
    ["_outputCode", false, [true]]
];

if (isNull _stateMachine) exitWith {"No state machine given."};
private _list = _stateMachine getVariable QGVAR(list);
private _updateCode = _stateMachine getVariable QGVAR(updateCode);
private _id = _stateMachine getVariable QGVAR(ID);

private _nl   = toString [13, 10];
private _nl2  = _nl   + _nl;
private _nli  = _nl   + "    ";
private _nli2 = _nli  + "    ";
private _nli3 = _nli2 + "    ";
private _output = "Statemachine ID " + str _id + _nl;

if (_outputList) then {
    _output = _output + "List:" + _nli + str _list + _nl2;
};

_output = _output + "Initial state: " + (_stateMachine getVariable QGVAR(initialState)) + _nl2;
if (_outputCode) then {
    _output = _output + "Update code: " + str _updateCode + _nl2;
};

_output = _output + "States: " + _nli;
{
    if (_outputCode) then {
        _output = _output + _x + _nli2;
        _output = _output + "onState: " + str (_stateMachine getVariable ONSTATE(_x)) + _nli;
    } else {
        _output = _output + _x + _nli;
    };

    {
        _x params ["_name", "_condition", "_targetState", "_onTransition"];
        if (_outputCode) then {
            _output = _output + "    " + format ["Transition %1:%2", _name, _nli3];
            _output = _output + "Condition: " + str _condition + _nli3;
            _output = _output + "Target: " + _targetState + _nli3;
            _output = _output + "onTransition: " + str _onTransition + _nli;
        } else {
            _output = _output + "    " + format ["%1 -> %2%3", _name, _targetState, _nli];
        };

        false
    } count (_stateMachine getVariable TRANSITIONS(_x));

    {
        _x params ["_name", "_events", "_condition", "_targetState", "_onTransition"];
        if (_outputCode) then {
            _output = _output + "    " + format ["Event transition %1:%2", _name, _nli3];
            _output = _output + "Events: " + (_events joinString ", ") + _nli3;
            _output = _output + "Condition: " + str _condition + _nli3;
            _output = _output + "Target: " + _targetState + _nli3;
            _output = _output + "onTransition: " + str _onTransition + _nli;
        } else {
            _output = _output + "    " + format ["%1 -> %2%3", _name, _targetState, _nli];
        };

        false
    } count (_stateMachine getVariable EVENTTRANSITIONS(_x));

    false
} count (_stateMachine getVariable QGVAR(states));

_output
