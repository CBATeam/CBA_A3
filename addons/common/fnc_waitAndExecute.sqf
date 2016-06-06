/* ----------------------------------------------------------------------------
Function: CBA_fnc_waitAndExecute

Description:
    Executes a code once in non sched environment with a given game time delay.

Parameters:
    _function - The function you wish to execute. <CODE>
    _args     - Parameters passed to the function executing. This will be the same array every execution. [optional] <ANY>
    _delay    - The amount of time in seconds between executions, 0 for every frame. [optional] (default: 0) <NUMBER>

Returns:
    Nothing

Examples:
    (begin example)
        [{player sideChat format ["5s later! _this: %1", _this];}, ["some","params",1,2,3], 5] call CBA_fnc_waitAndExecute;
    (end)

Author:
    esteldunedain and PabstMirror, donated from ACE3
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [["_function", {}, [{}]], ["_args", []], ["_delay", 0, [0]]];

GVAR(waitAndExecArray) pushBack [CBA_missionTime + _delay, _function, _args];
GVAR(waitAndExecArrayIsSorted) = false;
