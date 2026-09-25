/* ----------------------------------------------------------------------------
Function: CBA_fnc_promise_init

Description:
    Initializes the required variables for the promise system.

Parameters:
    Nothing

Returns:
    Nothing

Example:
    (begin example)
        [] call CBA_fnc_promise_init;
    (end)

Author:
    X39
---------------------------------------------------------------------------- */
#include "script_component.hpp"
isNil {
    if isNil QGVAR(requests) then {
        GVAR(requests) = [];
    };
};

nil
