/* ----------------------------------------------------------------------------
Function: CBA_fnc_isSheduled

Description:
    Check if the current scope is running in sheduled or unsheduled environment.

Parameters:
    None

Returns:
    true: sheduled - false: unsheduled <BOOLEAN>

Examples:
    (begin example)
        _result = call CBA_fnc_isSheduled;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

private _i = 10001;

// unsheduled environment will exit the while loop after 10000 iterations
while {_i > 0} do {_i = _i - 1};

_i == 0
