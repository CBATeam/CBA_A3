/* ----------------------------------------------------------------------------
Function: CBA_fnc_directCall

Description:
    Executes a piece of code in unscheduled environment.

Parameters:
    _code      - Code to execute <CODE>
    _arguments - Parameters to call the code with. [optional] <ANY>

Returns:
    None

Examples:
    (begin example)
        0 spawn {{systemChat str (call CBA_fnc_isScheduled)} call CBA_fnc_directCall}
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [["_code", {}, [{}]], ["_arguments", []]];

if (isNil QGVAR(directCallStack)) then {
    GVAR(directCallStack) = [];
};

private _id = GVAR(directCallStack) pushBack [_arguments, _code];

(format [
    QUOTE((GVAR(directCallStack) select %1 select 0) call (GVAR(directCallStack) select %1 select 1); GVAR(directCallStack) set [ARR_2(%1, nil)]; if ({!isNil QUOTE("_x")} count GVAR(directCallStack) == 0) then {GVAR(directCallStack) = [];}; false),
    _id
]) configClasses (configFile >> "CBA_DirectCall");

nil
