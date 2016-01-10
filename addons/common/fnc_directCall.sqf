/* ----------------------------------------------------------------------------
Function: CBA_fnc_directCall

Description:
    Executes a piece of code in unscheduled environment.

Parameters:
    _code      - Code to execute <CODE>
    _arguments - Parameters to call the code with. [optional] <ANY>

Returns:
    _return - Return value of the function <ANY>

Examples:
    (begin example)
        0 spawn {{systemChat str (call CBA_fnc_isScheduled)} call CBA_fnc_directCall}
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [["_code", {}, [{}]], ["_arguments", []]];

private "_return";

"_return = _arguments call _code; false" configClasses (configFile >> "CBA_DirectCall");

if (!isNil "_return") then {_return};
