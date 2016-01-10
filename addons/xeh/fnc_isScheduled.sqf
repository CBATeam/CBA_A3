/* ----------------------------------------------------------------------------
Function: CBA_fnc_isScheduled

Description:
    Check if the current scope is running in scheduled or unscheduled environment.

Parameters:
    None

Returns:
    true: scheduled - false: unscheduled <BOOLEAN>

Examples:
    (begin example)
        _result = call CBA_fnc_isScheduled;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

private _i = 10001;

// unscheduled environment will exit the while loop after 10000 iterations
while {_i > 0} do {_i = _i - 1};

_i == 0
