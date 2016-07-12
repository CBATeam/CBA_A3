/* ----------------------------------------------------------------------------
Function: CBA_fnc_waitUntilAndExecute

Description:
    Executes a code once in unscheduled environment after a condition is true.

Parameters:
    _condition - The function to evaluate as condition. <CODE>
    _statement - The function to run once the condition is true. <CODE>
    _args      - Parameters passed to the functions (statement and condition) executing. (optional) <ANY>

Passed Arguments:
    _this      - Parameters passed by this function. Same as '_args' above. <ANY>

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

params [["_condition", {}, [{}]], ["_statement", {}, [{}]], ["_args", []]];

GVAR(waitUntilAndExecArray) pushBack [_condition, _statement, _args];

nil
