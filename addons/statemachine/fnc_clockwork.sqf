#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_statemachine_fnc_clockwork

Description:
    Clockwork which runs all state machines.

Parameters:
    None

Returns:
    Nothing

Author:
    BaerMitUmlaut
---------------------------------------------------------------------------- */
SCRIPT(clockwork);

{
    for "_i" from 1 to (_x getVariable [QGVAR(ticksPerFrame), 1]) do {
        [_x] call FUNC(tick);
    };
} forEach GVAR(stateMachines);
