/* ----------------------------------------------------------------------------
Function: CBA_fnc_waitAndExecute

Description:
    Executes a code once in unscheduled environment with a given game time delay.
    Note that unlike PFEH, the delay is in CBA_missionTime not diag_tickTime (will be adjusted for time accl).

Parameters:
    _function - The function you wish to execute. <CODE>
    _args     - Parameters passed to the function executing. (optional) <ANY>
    _delay    - The amount of time in seconds before the code is executed. (optional, default: 0) <NUMBER>

Passed Arguments:
    _this     - Parameters passed by this function. Same as '_args' above. <ANY>

Returns:
    Nothing

Examples:
    (begin example)
        [{player sideChat format ["5s later! _this: %1", _this];}, ["some", "params", 1, 2, 3], 5] call CBA_fnc_waitAndExecute;
    (end)

Author:
    esteldunedain and PabstMirror, donated from ACE3
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [["_function", {}, [{}]], ["_args", []], ["_delay", 0, [0]]];

GVAR(waitAndExecArray) pushBack [CBA_missionTime + _delay, _function, _args];
GVAR(waitAndExecArrayIsSorted) = false;
