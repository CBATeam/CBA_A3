/* ----------------------------------------------------------------------------
Function: CBA_fnc_addPerFrameHandler

Description:
    Add a handler that will execute every frame, or every x number of seconds

Parameters:
    _func - The function you wish to execute
    _delay - The amount of time in seconds (can be less than 0) between executions, 0 for everyframe.
    _params - Parameters passed to the function executing. This will be the same array every execution.

Returns:
    _handle - a number representing the handle of the function. Use this to remove the handler.

Examples:
    (begin example)
        [{player sideChat format["every frame! _this: %1", _this];}, 0, ["some","params",1,2,3]] call CBA_fnc_addPerFrameHandler;
    (end)

Author:
    Nou & Jaynus, donated from ACRE project code for use by the community.

---------------------------------------------------------------------------- */
#include "script_component.hpp"

private ["_handle", "_data", "_publicHandle"];
params ["_func","_delay", ["_params",[]]];

if (!isNil "_func") then {
    _handle = if (GVAR(nextPFHid) == -1) then {
        GVAR(nextPFHid) = count GVAR(perFrameHandlerArray);
        GVAR(nextPFHid)
    } else {
        GVAR(nextPFHid) = GVAR(nextPFHid) + 1;
        GVAR(nextPFHid)
    };

    _publicHandle = GVAR(PFHhandles) pushback _handle;
    _data = [_func, _delay, 0, diag_tickTime, _params, _publicHandle];
    GVAR(perFrameHandlerArray) pushBack _data;
};
_publicHandle
