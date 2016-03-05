/* ----------------------------------------------------------------------------
Function: CBA_fnc_waitUntilAndExecute

Description:
    Executes a code once in non sched environment after a condition is true.

Parameters:
    _conditionFunction - The function to evaluate as condition. <CODE>
    _statementFunction - The function to run once the condition is true. <CODE>
    _args     - Parameters passed to the function executing. This will be the same array every execution. [optional] <ANY>

Returns:
    Nothing

Examples:
    (begin example)
        [{(_this select 0) == vehicle (_this select 0)}, {(_this select 0) setDamage 1;}, [player]] call CBA_fnc_waitUntilAndExecute;
    (end)

Author:
    joko // Jonas, donated from ACE3
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [["_conditionFunction", {}, [{}]], ["_statementFunction", {}, [{}]], ["_args", []]];

GVAR(waitUntilAndExecArray) pushBack [_conditionFunction, _statementFunction, _args];
