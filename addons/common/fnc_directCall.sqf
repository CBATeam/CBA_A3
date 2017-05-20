/* ----------------------------------------------------------------------------
Function: CBA_fnc_directCall

Description:
    Executes a piece of code in unscheduled environment.

Parameters:
    _code      - Code to execute <CODE>
    _arguments - Parameters to call the code with. (optional) <ANY>

Returns:
    _return - Return value of the function <ANY>

Examples:
    (begin example)
        0 spawn { {systemChat str canSuspend} call CBA_fnc_directCall; };
        -> false
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [["_CBA_code", {}, [{}]], ["_this", []]];

private "_CBA_return";

isNil {
    _CBA_return = [_x] apply _CBA_code select 0;
};

if (!isNil "_CBA_return") then {_CBA_return};
